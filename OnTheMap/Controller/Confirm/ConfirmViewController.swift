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

    @IBOutlet weak var confirmMapView: MKMapView!
    
    var location: String!
    var url: String!
    var coordinate: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Confirm Location"
        
        setPointAnnotation()
    }
    
    func setPointAnnotation() {
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = location
        pointAnnotation.coordinate = coordinate
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000)
        
        confirmMapView.addAnnotation(pointAnnotation)
        confirmMapView.setRegion(coordinateRegion, animated: true)
    }
}
