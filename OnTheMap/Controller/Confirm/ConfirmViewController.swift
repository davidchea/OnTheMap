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
    
    var locationData = [String: Any]()
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Confirm Location"
        
        setPointAnnotation()
    }
    
    func setPointAnnotation() {
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = locationData["city"] as? String
        pointAnnotation.coordinate = locationData["coordinate"] as! CLLocationCoordinate2D
        
        let coordinateRegion = MKCoordinateRegion(center: pointAnnotation.coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000)
        
        confirmMapView.addAnnotation(pointAnnotation)
        confirmMapView.setRegion(coordinateRegion, animated: true)
    }
}
