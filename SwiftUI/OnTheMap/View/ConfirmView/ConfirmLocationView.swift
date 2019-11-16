//
//  ConfirmLocationView.swift
//  OnTheMap
//
//  Created by David Chea on 10/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI
import MapKit

struct ConfirmLocationView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appData: AppData
    
    @Environment(\.presentationMode) private var presentationMode
    
    let locality: String!
    let coordinate: CLLocationCoordinate2D!
    
    let url: String!
    
    // MARK: - View
    
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack {
                ConfirmLocationMapView(locality: self.locality, coordinate: self.coordinate)
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    Spacer()

                    Button("CONFIRM LOCATION") {
                        UdacityAPI.addStudentLocation(
                            mapString: self.locality,
                            mediaURL: self.url,
                            latitude: self.coordinate!.latitude,
                            longitude: self.coordinate!.longitude,
                            completionHandler: self.dismissView(isPassed:)
                        )
                    }
                    .padding(.vertical, 5)
                    .frame(width: geometryProxy.size.width - 30)
                    .foregroundColor(.white)
                    .background(Color(red: 51 / 255, green: 181 / 255, blue: 229 / 255))
                    .cornerRadius(5)
                }
                .padding(.bottom, 30)
            }
        }
        .alert(isPresented: $appData.isShowingAlert) {
            Alert(title: Text("Internal error"), message: Text("An error occurred, please try again later."), dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK: - Methods
    
    private func dismissView(isPassed: Bool) {
        guard isPassed else {
            appData.isShowingAlert = true
            
            return
        }
        
        UdacityAPI.getAllStudentLocation(completionHandler: self.setAllStudentLocation(json:))
        presentationMode.wrappedValue.dismiss()
    }
    
    private func setAllStudentLocation(json: Results?) {
        guard let json = json else {
            appData.isShowingAlert = true
                   
            return
        }
        
        appData.allStudentLocation = json.results
    }
}
