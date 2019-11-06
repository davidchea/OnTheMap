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
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Image("image-udacity-clear")
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            NavigationLink(destination: MapView(), tag: 1, selection: $selection) {
                Button(action: {
                    self.selection = 1
                }) {
                    Text("LOG IN")
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color(red: 51 / 255, green: 181 / 255, blue: 229 / 255))
            .cornerRadius(10)
            
            Text("Don't have an account? Sign up.")
        }
        .padding()
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
