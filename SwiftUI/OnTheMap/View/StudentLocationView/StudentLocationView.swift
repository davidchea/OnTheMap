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
    
    @EnvironmentObject private var studentLocationData: StudentLocationData
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isShowingInternalErrorAlert = false
    @State private var isShowingAddStudentLocationView = false
    
    // MARK: - Views
    
    var body: some View {
        NavigationView {
            TabView {
                MapView()
                    .environmentObject(studentLocationData)
                    .tabItem {
                        Image(systemName: "map.fill")
                    }
                
                List {
                    ForEach(studentLocationData.allStudentLocation) { studentLocation in
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
        .onAppear {
            UdacityAPI.getAllStudentLocation(completionHandler: self.setAllStudentLocation(dataCodable:))
        }
        .alert(isPresented: $isShowingInternalErrorAlert) {
            Alert(title: Text("Internal error"), message: Text("An error occurred, please try again later."), dismissButton: .default(Text("OK")))
        }
    }
    
    var logOutButton: some View {
        Button("Log Out") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    var refreshButton: some View {
        Button(action: { UdacityAPI.getAllStudentLocation(completionHandler: self.setAllStudentLocation(dataCodable:)) }) {
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
    
    // MARK: - Method
    
    private func setAllStudentLocation(dataCodable: Results?) {
        guard let dataCodable = dataCodable else {
            isShowingInternalErrorAlert = true
                   
            return
        }
        
        studentLocationData.allStudentLocation = dataCodable.results
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
