//
//  StudentLocationRow.swift
//  OnTheMap
//
//  Created by David Chea on 10/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI

struct StudentLocationRow: View {
    
    // MARK: - Property
    
    let studentLocation: StudentLocation
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Image("image-pin")
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
}
