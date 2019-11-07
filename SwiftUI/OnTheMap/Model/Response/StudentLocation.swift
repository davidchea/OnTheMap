//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by David Chea on 07/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

struct StudentLocation: Codable {
    
    let objectID: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    let createdAt: String
    let updatedAt: String
}
