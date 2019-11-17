//
//  StudentLocationRow.swift
//  OnTheMap
//
//  Created by David Chea on 10/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI

struct StudentLocationRow: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appData: AppData
    
    let studentLocation: StudentLocation
    
    // MARK: - View
    
    var body: some View {
        Button(action: { self.openURL() }) {
            HStack {
                Image("image-pin")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text("\(studentLocation.firstName) \(studentLocation.lastName)")
                    Text(studentLocation.mediaURL)
                }
                .font(.system(size: 15))
            }
        }
        .alert(isPresented: $appData.isShowingAlert) {
            Alert(title: Text("Invalid URL"), message: nil, dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK: - Method
    
    private func openURL() {
        let mediaURL = studentLocation.mediaURL
        
        guard let url = URL(string: mediaURL) else {
            appData.isShowingAlert = true
            
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
