//
//  StudentLocationView.swift
//  OnTheMap
//
//  Created by David Chea on 06/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI

struct StudentLocationView: View {
    
    // MARK: - Property
    
    @EnvironmentObject private var data: Data
    
    // MARK: - View
    
    var body: some View {
        TabView {
            MapView()
                .environmentObject(data)
                .tabItem {
                    Image(systemName: "map.fill")
                }
            
            List {
                ForEach(data.allStudentLocation) { studentLocation in
                    StudentLocationRow(studentLocation: studentLocation)
                }
            }
            .tabItem {
                Image(systemName: "list.bullet")
            }
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
