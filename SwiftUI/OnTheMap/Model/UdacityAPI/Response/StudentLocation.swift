//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by David Chea on 07/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

class StudentLocation: Codable, Identifiable {
    
    // MARK: - Properties
    
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
    
    // MARK: - Initializer
    
    init(
        objectId: String,
        uniqueKey: String,
        firstName: String,
        lastName: String,
        mapString: String,
        mediaURL: String,
        latitude: Double,
        longitude: Double,
        createdAt: String,
        updatedAt: String
    ) {
        self.objectId = objectId
        self.uniqueKey = uniqueKey
        self.firstName = firstName
        self.lastName = lastName
        self.mapString = mapString
        self.mediaURL = mediaURL
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
