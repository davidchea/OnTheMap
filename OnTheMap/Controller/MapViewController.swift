//
//  MapViewController.swift
//  OnTheMap
//
//  Created by David Chea on 05/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var studentLocationMapView: MKMapView!
    @IBOutlet weak var mapActivityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewData()
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        refresh()
    }
}

extension MapViewController: DataSetting {
    
    func setViewData() {
        mapActivityIndicatorView.startAnimating()
        UdacityAPI.getAllStudentLocation(completion: setViewData(dataCodable:))
    }
    
    func setViewData(dataCodable: Results) {
        mapActivityIndicatorView.stopAnimating()
        
        StudentLocationData.setAllStudentLocation(allStudentLocation: dataCodable.results)
        StudentLocationData.setAllStudentLocationPointAnnotation()
        studentLocationMapView.addAnnotations(StudentLocationData.allStudentLocationPointAnnotation)
    }
    
    func refresh() {
        let annotations = studentLocationMapView.annotations
        studentLocationMapView.removeAnnotations(annotations)
        
        setViewData()
    }
}

extension MapViewController: MKMapViewDelegate {}
