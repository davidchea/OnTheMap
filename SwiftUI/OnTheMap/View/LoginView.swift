//
//  LoginView.swift
//  OnTheMap
//
//  Created by David Chea on 06/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI
import SwiftyJSON

struct LoginView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appData: AppData
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var selection: Int!
    
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
                    
                    NavigationLink(destination: StudentLocationView().environmentObject(self.appData), tag: 0, selection: self.$selection) {
                        Button("LOG IN") {
                            UdacityAPI.addSession(email: self.email, password: self.password, completionHandler: self.logIn(json:))
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
        .alert(isPresented: $appData.isShowingAlert) {
            switch appData.alertType {
            case .emptyField:
                return Alert(title: Text("Empty field"), message: Text("Please fill email and password fields."), dismissButton: .default(Text("OK")))
            case .internalError:
                return Alert(title: Text("Internal error"), message: Text("An error occurred, please try again later."), dismissButton: .default(Text("OK")))
            case .wrongEntry:
                return Alert(title: Text("Login failed"), message: Text("Incorrect email and/or password."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // MARK: - Method
    
    private func logIn(json: JSON) {
        guard !email.isEmpty, !password.isEmpty else {
            appData.isShowingAlert = true
            appData.alertType = .emptyField
            
            return
        }
        
        guard json["error"] != "Internal error" else {
            appData.isShowingAlert = true
            appData.alertType = .internalError
            
            return
        }
        
        guard json["error"].string == nil else {
            appData.isShowingAlert = true
            appData.alertType = .wrongEntry
            
            return
        }
        
        email = ""
        password = ""
        
        // LOG IN
        selection = 0
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
