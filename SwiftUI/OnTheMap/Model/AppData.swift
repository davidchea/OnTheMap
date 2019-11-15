//
//  AppData.swift
//  OnTheMap
//
//  Created by David Chea on 10/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI

final class AppData: ObservableObject {
    
    enum AlertType {
        case emptyField, internalError, wrongEntry
    }
    
    @Published var allStudentLocation = [StudentLocation]()
    
    @Published var isShowingAlert = false
    @Published var alertType: AlertType = .emptyField
}
