//
//  StudentLocationView.swift
//  OnTheMap
//
//  Created by David Chea on 06/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI

struct StudentLocationView: View {
    
    // MARK: - View
    
    var body: some View {
        TabView {
            MapView()
                .tabItem { Image(systemName: "map.fill") }
            
            List {
                Text("List")
            }
            .tabItem { Image(systemName: "list.bullet") }
        }
    }
}

struct StudentLocationView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 11 Pro Max"], id: \.self) { deviceName in
            StudentLocationView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
