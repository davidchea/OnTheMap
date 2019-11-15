//
//  AddStudentLocationView.swift
//  OnTheMap
//
//  Created by David Chea on 10/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI
import MapKit

struct AddStudentLocationView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appData: AppData
    
    @State private var location = ""
    @State private var url = ""
    
    @State private var locality: String!
    @State private var coordinate: CLLocationCoordinate2D!
    
    @State private var selection: Int!
    
    // MARK: - View
    
    var body: some View {
        GeometryReader { geometryProxy in
            NavigationView {
                VStack(spacing: 15) {
                    Spacer()

                    Image("image-world")
                    
                    Spacer()
                    
                    TextField("Location", text: self.$location)
                        .padding(.horizontal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("URL", text: self.$url)
                        .padding(.horizontal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    NavigationLink(destination: ConfirmLocationView(locality: self.locality, coordinate: self.coordinate), tag: 0, selection: self.$selection) {
                        Button("FIND LOCATION") {
                            self.findLocation()
                        }
                    }
                    .padding(.vertical, 5)
                    .frame(width: geometryProxy.size.width - 30)
                    .foregroundColor(.white)
                    .background(Color(red: 51 / 255, green: 181 / 255, blue: 229 / 255))
                    .cornerRadius(5)
                    
                    Spacer()
                }
                .navigationBarTitle("AddStudentLocation")
                .navigationBarHidden(true)
            }
        }
        .alert(isPresented: $appData.isShowingAlert) {
            switch appData.alertType {
            case .emptyField:
                return Alert(title: Text("Empty field"), message: Text("Please fill email and password fields."), dismissButton: .default(Text("OK")))
            case .internalError:
                return Alert(title: Text("Internal error"), message: Text("An error occurred, please try again later."), dismissButton: .default(Text("OK")))
            case .wrongEntry:
                return Alert(title: Text("Failed to find location"), message: Text("Please enter a correct location."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // MARK: - Methods
    
    private func findLocation() {
        guard !location.isEmpty, !url.isEmpty else {
            appData.isShowingAlert = true
            appData.alertType = .emptyField
            
            return
        }
        
        CLGeocoder().geocodeAddressString(location, completionHandler: confirmLocation(placemarks:error:))
    }
    
    private func confirmLocation(placemarks: [CLPlacemark]?, error: Error?) {
        guard error == nil else {
            let errorCode = (error as NSError?)!.code
            if errorCode == 8 {
                appData.isShowingAlert = true
                appData.alertType = .wrongEntry
            } else {
                appData.isShowingAlert = true
                appData.alertType = .internalError
                
                print(error!.localizedDescription)
            }
            
            return
        }
        
        let placemark = placemarks!.first!
        locality = placemark.locality!
        coordinate = placemark.location!.coordinate
        
        // FIND LOCATION
        selection = 0
    }
}

struct AddStudentLocationView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 11 Pro Max"], id: \.self) { deviceName in
            AddStudentLocationView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
