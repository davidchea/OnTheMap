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
        GeometryReader { geometryProxy in
            VStack(spacing: 15) {
                Spacer()
                
                Image("image-udacity-clear")
                
                Spacer()
                
                TextField("Email", text: self.$email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: self.$password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                NavigationLink(destination: MapView(), tag: 1, selection: self.$selection) {
                    Button("LOG IN") {
                        self.selection = 1
                    }
                }
                .padding(.vertical, 5)
                .frame(width: geometryProxy.size.width)
                .foregroundColor(.white)
                .background(Color(red: 51 / 255, green: 181 / 255, blue: 229 / 255))
                .cornerRadius(5)
                
                HStack(spacing: 0) {
                    Text("Don't have an account? ")
                    
                    Button("Sign up.") {}
                }
                
                Spacer()
            }
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
