//
//  StudentLocationAnnotation.swift
//  OnTheMap
//
//  Created by David Chea on 11/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import MapKit

final class StudentLocationAnnotation: NSObject, MKAnnotation {
    
    // MARK: - Properties
    
    let name: String
    let mediaURL: String
    let coordinate: CLLocationCoordinate2D
    
    // MARK: - Initializer
    
    init(studentLocation: StudentLocation) {
        let name = "\(studentLocation.firstName) \(studentLocation.lastName)"
        let mediaURL = studentLocation.mediaURL
        
        let latitude = CLLocationDegrees(studentLocation.latitude)
        let longitude = CLLocationDegrees(studentLocation.longitude)
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        self.name = name
        self.mediaURL = mediaURL
        self.coordinate = coordinate
    }
}
