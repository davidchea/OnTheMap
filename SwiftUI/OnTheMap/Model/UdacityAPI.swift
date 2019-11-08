//
//  UdacityAPI.swift
//  OnTheMap
//
//  Created by David Chea on 07/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import Foundation

class UdacityAPI {
    
    enum Endpoint: String {
        static let base = "https://onthemap-api.udacity.com/v1/"
        
        case session, studentLocation
        
        var stringValue: String {
            switch self {
            case .session:
                return "\(Endpoint.base)session"
            case .studentLocation:
                return "\(Endpoint.base)StudentLocation?limit=100&order=-updatedAt"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    /**
     Add a session to use the app.
    
     - Parameters:
        - email: The email.
        - password: The password.
        - completionHandler: The closure in which the response will be handled.
     */
    static func addSession(email: String, password: String, completionHandler: @escaping ([String: Any]?) -> Void) {
        var request = URLRequest(url: Endpoint.session.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let login = Login(username: email, password: password)
        let udacity = Udacity(udacity: login)
        let udacityJSON = try! JSONEncoder().encode(udacity)
        request.httpBody = udacityJSON
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    print(error!.localizedDescription)
                    completionHandler(nil)
                }
             
                return
            }
            
            // The first five characters are used for security purpose and we need to skip them.
            let newData = data!.subdata(in: 5..<data!.count)
            let dataJSON = try! JSONSerialization.jsonObject(with: newData, options: []) as! [String: Any]
            DispatchQueue.main.async { completionHandler(dataJSON) }
        }
        task.resume()
    }
    
    /**
     Get the most recent 100 `StudentLocation`.
     
     - Parameter completionHandler: The closure in which the response will be handled.
     */
    static func getAllStudentLocation(completionHandler: @escaping (Results?) -> Void) {
        let request = URLRequest(url: Endpoint.studentLocation.url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    print(error!.localizedDescription)
                    completionHandler(nil)
                }
                
                return
            }
            
            let dataCodable = try! JSONDecoder().decode(Results.self, from: data!)
            DispatchQueue.main.async { completionHandler(dataCodable) }
        }
        task.resume()
    }
    
    /**
     Add a `StudentLocation`.
     
     - Parameters:
        - mapString: The location name.
        - mediaURL: The student URL.
        - latitude: The location latitude.
        - longitude: The location longitude.
        - completionHandler: The closure in which the response will be handled.
     */
    static func addStudentLocation(mapString: String, mediaURL: String, latitude: Double, longitude: Double, completionHandler: @escaping (Bool) -> Void) {
        var request = URLRequest(url: Endpoint.studentLocation.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let studentLocation = StudentLocation(
            objectID: "",
            uniqueKey: "",
            firstName: "Jacques",
            lastName: "Chirac",
            mapString: mapString,
            mediaURL: mediaURL,
            latitude: latitude,
            longitude: longitude,
            createdAt: "",
            updatedAt: ""
        )
        let studentLocationJSON = try! JSONEncoder().encode(studentLocation)
        request.httpBody = studentLocationJSON
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    print(error!.localizedDescription)
                    completionHandler(false)
                }
                
                return
            }
            
            DispatchQueue.main.async { completionHandler(true) }
        }
        task.resume()
    }
}
