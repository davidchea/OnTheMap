//
//  UdacityAPI.swift
//  OnTheMap
//
//  Created by David Chea on 01/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import Foundation

class UdacityAPI {
    
    /// Log in to Udacity and get/add/update `StudentLocation`.
    enum Endpoint: String {
        static let base = "https://onthemap-api.udacity.com/v1/"
        
        /// Log in.
        case session
        
        /// Get/add/update `StudentLocation`.
        case studentLocation
        
        var stringValue: String {
            switch self {
            case .session:
                return "\(Endpoint.base)session"
            case .studentLocation:
                return "\(Endpoint.base)StudentLocation"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    /**
     Create a session to use the app.
    
     - Parameters:
        - email: The email.
        - password: The password.
        - completion: The closure in which the response (a dictionary) will be handled.
     */
    static func createSession(email: String, password: String, completion: @escaping ([String: Any]) -> Void) {
        // Get the session endpoint and create the request
        var request = URLRequest(url: Endpoint.session.url)
        
        // Set values to the request
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Set email and password to the request
        let login = Login(username: email, password: password)
        let udacity = Udacity(udacity: login)
        let udacityJson = try! JSONEncoder().encode(udacity)
        request.httpBody = udacityJson
        
        // Check if it is correct email and password then log in
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            // The first five characters are used for security purpose, need to skip them
            let newData = data.subdata(in: 5..<data.count)
            let dataJson = try! JSONSerialization.jsonObject(with: newData, options: []) as! [String: Any]
            DispatchQueue.main.async { completion(dataJson) }
        }
        task.resume()
    }
    
    /**
     Get the most recent hundred `StudentLocation`.
     
     - Parameter completion: The closure in which the response (a `Codable`) will be handled.
     */
    static func getStudentLocationData(completion: @escaping (Results) -> Void) {
        let request = URLRequest(url: Endpoint.studentLocation.url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            // Decode the response to a Codable object
            let dataCodable = try! JSONDecoder().decode(Results.self, from: data)
            DispatchQueue.main.async { completion(dataCodable) }
        }
        task.resume()
    }
}
