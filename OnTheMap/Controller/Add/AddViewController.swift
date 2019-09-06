//
//  AddViewController.swift
//  OnTheMap
//
//  Created by David Chea on 05/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit
import MapKit

class AddViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    // MARK: Actions
    
    @IBAction func findLocation() {
        let location = locationTextField.text!
        let url = urlTextField.text!
        
        if location.isEmpty && url.isEmpty {
            displayAlert(title: "Empty field", message: "Please fill location and URL fields.")
        } else {
            CLGeocoder().geocodeAddressString(location, completionHandler: handleGeocodeAddressString(placemarks:error:))
        }
    }
    
    // MARK: Methods
    
    func handleGeocodeAddressString(placemarks: [CLPlacemark]?, error: Error?) {
        let coordinate = placemarks![0].location!.coordinate
        performSegue(withIdentifier: "confirmLocation", sender: coordinate)
    }
}
