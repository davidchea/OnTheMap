//
//  LoginView.swift
//  OnTheMap
//
//  Created by David Chea on 06/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties
    
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
                    
                    NavigationLink(destination: StudentLocationView(), tag: 1, selection: self.$selection) {
                        Button("LOG IN") {
                            UdacityAPI.addSession(email: self.email, password: self.password, completionHandler: self.completionHandler(dataJSON:))
                        }
                    }
                    .padding(.vertical, 5)
                    .frame(width: geometryProxy.size.width / 4)
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
    
    // MARK: - Method
    
    private func completionHandler(dataJSON: [String: Any]?) {
        guard let dataJSON = dataJSON else {
            isShowingInternalErrorAlert = true
            
            return
        }
        
        guard dataJSON["error"] == nil else {
            isShowingLoginFailedAlert = true
            
            return
        }
        
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
