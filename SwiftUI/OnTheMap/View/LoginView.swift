//
//  LoginView.swift
//  OnTheMap
//
//  Created by David Chea on 06/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI
import MapKit

struct LoginView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var data: Data
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var selection: Int!
    
    @State private var isShowingInternalErrorAlert = false
    @State private var isShowingLoginFailedAlert = false
    
    // MARK: - View
    
    var body: some View {
        GeometryReader { geometryProxy in
            NavigationView {
                VStack(spacing: 15) {
                    Spacer()

                    Image("image-udacity-clear")
                    
                    Spacer()
                    
                    TextField("Email", text: self.$email)
                        .padding(.horizontal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                    SecureField("Password", text: self.$password)
                        .padding(.horizontal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    NavigationLink(destination: StudentLocationView().environmentObject(self.data), tag: 1, selection: self.$selection) {
                        Button("LOG IN") {
                            UdacityAPI.addSession(email: self.email, password: self.password, completionHandler: self.addSessionCompletionHandler(dataJSON:))
                        }
                    }
                    .padding(.vertical, 5)
                    .frame(width: geometryProxy.size.width - 30)
                    .foregroundColor(.white)
                    .background(Color(red: 51 / 255, green: 181 / 255, blue: 229 / 255))
                    .cornerRadius(5)
                    
                    HStack(spacing: 0) {
                        Text("Don't have an account? ")
                        
                        Button("Sign up.") {}
                    }
                    
                    Spacer()
                }
                .navigationBarTitle("Login")
                .navigationBarHidden(true)
            }
        }
        .alert(isPresented: $isShowingInternalErrorAlert) {
            Alert(title: Text("Internal error"), message: Text("An error occurred, please try again later."), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $isShowingLoginFailedAlert) {
            Alert(title: Text("Login failed"), message: Text("Incorrect email and/or password."), dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK: - Methods
    
    private func addSessionCompletionHandler(dataJSON: [String: Any]?) {
        guard let dataJSON = dataJSON else {
            isShowingInternalErrorAlert = true
            
            return
        }
        
        guard dataJSON["error"] == nil else {
            isShowingLoginFailedAlert = true
            
            return
        }
        
        UdacityAPI.getAllStudentLocation(completionHandler: setData(dataCodable:))
    }
    
    private func setData(dataCodable: Results?) {
        guard let dataCodable = dataCodable else {
            isShowingInternalErrorAlert = true
                   
            return
        }
        
        data.allStudentLocation = dataCodable.results
        setAllPointAnnotation(allStudentLocation: data.allStudentLocation)
    }
    
    private func setAllPointAnnotation(allStudentLocation: [StudentLocation]) {
        for studentLocation in allStudentLocation {
            let firstName = studentLocation.firstName
            let lastName = studentLocation.lastName
            let mediaURL = studentLocation.mediaURL
            
            let latitude = CLLocationDegrees(studentLocation.latitude)
            let longitude = CLLocationDegrees(studentLocation.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.title = "\(firstName) \(lastName)"
            pointAnnotation.subtitle = mediaURL
            pointAnnotation.coordinate = coordinate
            
            data.allPointAnnotation.append(pointAnnotation)
        }
        
        // LOG IN
        self.selection = 1
    }
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 11 Pro Max"], id: \.self) { deviceName in
            LoginView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
