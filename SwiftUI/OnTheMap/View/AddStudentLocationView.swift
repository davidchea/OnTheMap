//
//  AddStudentLocationView.swift
//  OnTheMap
//
//  Created by David Chea on 10/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI

struct AddStudentLocationView: View {
    
    // MARK: - Properties
    
    @State private var location = ""
    @State private var url = ""
    
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
                    
                    NavigationLink(destination: ConfirmView(), tag: 1, selection: self.$selection) {
                        Button("FIND LOCATION") {
                            self.selection = 1
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
