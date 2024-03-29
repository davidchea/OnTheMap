//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by David Chea on 03/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

struct StudentLocation: Codable {
    
    let objectId: String
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
