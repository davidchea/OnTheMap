//
//  ConfirmViewController.swift
//  OnTheMap
//
//  Created by David Chea on 06/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit
import MapKit

class ConfirmViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var confirmMapView: MKMapView!
    @IBOutlet weak var confirmActivityIndicatorView: UIActivityIndicatorView!
    
    // MARK: Properties
    
    var locationData = [String: Any]()
    var url: String!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Confirm Location"
        
        setPointAnnotation()
    }
    
    // MARK: Actions
    
    /// Add a `StudentLocation` using the Udacity API.
    @IBAction func addStudentLocation() {
        confirmActivityIndicatorView.startAnimating()
        
        UdacityAPI.addStudentLocation(
            mapString: locationData["location"] as! String,
            mediaURL: url,
            latitude: (locationData["coordinate"] as! CLLocationCoordinate2D).latitude,
            longitude: (locationData["coordinate"] as! CLLocationCoordinate2D).longitude,
            completionHandler: handleAddStudentLocationResponse(jsonData:)
        )
    }
    
    // MARK: Methods
    
    /// Add a pin to the map and zoom in on the location.
    func setPointAnnotation() {
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = locationData["location"] as? String
        pointAnnotation.coordinate = locationData["coordinate"] as! CLLocationCoordinate2D
        
        let coordinateRegion = MKCoordinateRegion(center: pointAnnotation.coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000)
        
        confirmMapView.addAnnotation(pointAnnotation)
        confirmMapView.setRegion(coordinateRegion, animated: true)
    }
    
    /**
     Return to `MapViewController` or `TableViewController` if the `StudentLocation` was successfully added.
     
     - Parameter jsonData: The JSON response send by the Udacity API to add a `StudentLocation`.
     */
    func handleAddStudentLocationResponse(jsonData: [String: Any]) {
        confirmActivityIndicatorView.stopAnimating()
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
}
