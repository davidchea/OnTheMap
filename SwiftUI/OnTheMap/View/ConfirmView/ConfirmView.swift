//
//  ConfirmView.swift
//  OnTheMap
//
//  Created by David Chea on 10/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI

struct ConfirmView: View {
    
    // MARK: - View
    
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack {
                FindLocationMapView()
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    Spacer()

                    Button("FINISH") {}
                    .padding(.vertical, 5)
                    .frame(width: geometryProxy.size.width - 30)
                    .foregroundColor(.white)
                    .background(Color(red: 51 / 255, green: 181 / 255, blue: 229 / 255))
                    .cornerRadius(5)
                }
                .padding(.bottom, 30)
            }
        }
    }
}

struct ConfirmView_Previews: PreviewProvider {
    
    static var previews: some View {
        ConfirmView()
    }
}
