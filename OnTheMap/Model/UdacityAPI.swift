//
//  UdacityAPI.swift
//  OnTheMap
//
//  Created by David Chea on 01/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import Foundation

class UdacityAPI {
    
    enum Endpoint: String {
        case session = "https://onthemap-api.udacity.com/v1/session"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
}
