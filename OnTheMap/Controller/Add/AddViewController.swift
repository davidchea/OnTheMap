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
    @IBOutlet weak var addLoginIndicatorView: UIActivityIndicatorView!
    
    // MARK: Inherited methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let confirmViewController = segue.destination as! ConfirmViewController
        confirmViewController.location = locationTextField.text
        confirmViewController.url = urlTextField.text
        confirmViewController.coordinate = sender as? CLLocationCoordinate2D
    }
    
    // MARK: Actions
    
    @IBAction func findLocation() {
        let location = locationTextField.text!
        let url = urlTextField.text!
        
        guard !location.isEmpty, !url.isEmpty else {
            displayAlert(title: "Empty field", message: "Please fill location and URL fields.")
            
            return
        }
        
        addLoginIndicatorView.startAnimating()
        CLGeocoder().geocodeAddressString(location, completionHandler: handleGeocodeAddressString(placemarks:error:))
    }
    
    // MARK: Methods
    
    func handleGeocodeAddressString(placemarks: [CLPlacemark]?, error: Error?) {
        addLoginIndicatorView.stopAnimating()
        
        guard let placemarks = placemarks else {
            displayAlert(title: "Failed to find location", message: "Please enter a correct location.")
            
            return
        }
        
        let coordinate = placemarks[0].location!.coordinate
        performSegue(withIdentifier: "confirmLocation", sender: coordinate)
    }
}
