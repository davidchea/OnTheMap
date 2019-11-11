//
//  StudentLocationData.swift
//  OnTheMap
//
//  Created by David Chea on 10/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI

final class StudentLocationData: ObservableObject {
    
    @Published var allStudentLocation = [StudentLocation]()
}
