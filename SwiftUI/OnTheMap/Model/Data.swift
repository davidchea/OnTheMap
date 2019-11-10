//
//  Data.swift
//  OnTheMap
//
//  Created by David Chea on 10/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI
import MapKit

final class Data: ObservableObject {
    
    @Published var allStudentLocation = [StudentLocation]()
    @Published var allPointAnnotation = [MKPointAnnotation]()
}
