//
//  StudentLocationView.swift
//  OnTheMap
//
//  Created by David Chea on 06/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI

struct StudentLocationView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var data: Data
    
    @State private var isShowingAddStudentLocationView = false
    
    // MARK: - Views
    
    var body: some View {
        NavigationView {
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
            .padding(.top)
            .navigationBarTitle("Latest Students")
            .navigationBarItems(
                leading: logOutButton,
                trailing:
                    HStack(spacing: 30) {
                        refreshButton
                        addButton
                    }
            )
        }
    }
    
    var logOutButton: some View {
        Button("Log Out") {}
    }
    
    var refreshButton: some View {
        Button(action: {}) {
            Image(systemName: "arrow.clockwise")
                .imageScale(.large)
        }
    }
    
    var addButton: some View {
        Button(action: { self.isShowingAddStudentLocationView.toggle() }) {
            Image(systemName: "plus")
                .imageScale(.large)
        }
        .sheet(isPresented: $isShowingAddStudentLocationView) {
            AddStudentLocationView()
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
