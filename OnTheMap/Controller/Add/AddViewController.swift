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
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTapGestureRecognizer()
    }
    
    // MARK: Inherited methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let confirmViewController = segue.destination as! ConfirmViewController
        confirmViewController.locationData = sender as! [String: Any]
        confirmViewController.url = urlTextField.text
    }
    
    // MARK: Actions
    
    /// Try to find the location from the user input.
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
    
    /**
     Go to `ConfirmViewController` if the location was found or display an alert box if not.
     
     - Parameters:
        - placemarks: For most geocoding requests, this array should contain only one entry.
        - error: Contains `nil` or an error object indicating why the placemark data was not returned.
     */
    func handleGeocodeAddressString(placemarks: [CLPlacemark]?, error: Error?) {
        addLoginIndicatorView.stopAnimating()
        
        guard let placemarks = placemarks, let placemark = placemarks.first else {
            displayAlert(title: "Failed to find location", message: "Please enter a correct location.")
            
            return
        }
        
        let locationData: [String: Any] = [
            "location": placemark.locality!,
            "coordinate": placemark.location!.coordinate
        ]
        performSegue(withIdentifier: "confirmLocation", sender: locationData)
    }
}
