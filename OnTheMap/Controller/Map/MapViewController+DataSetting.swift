//
//  MapViewController+DataSetting.swift
//  OnTheMap
//
//  Created by David Chea on 06/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

extension MapViewController: DataSetting {
    
    // MARK: Protocol methods
    
    func setViewData() {
        mapActivityIndicatorView.startAnimating()
        UdacityAPI.getAllStudentLocation(completionHandler: setViewData(dataCodable:))
    }
    
    func setViewData(dataCodable: Results?) {
        mapActivityIndicatorView.stopAnimating()
        
        guard let dataCodable = dataCodable else {
            displayAlert(title: "Internal error", message: "An error occurred, please try again later.")
            
            return
        }
        
        // Set all the StudentLocation
        StudentLocationData.allStudentLocation = dataCodable.results
        
        // Set all the annotations
        StudentLocationData.setAllStudentLocationPointAnnotation()
        
        // Add all the annocations on the map
        studentLocationMapView.addAnnotations(StudentLocationData.allStudentLocationPointAnnotation)
    }
    
    func refresh() {
        let annotations = studentLocationMapView.annotations
        studentLocationMapView.removeAnnotations(annotations)
        
        setViewData()
    }
}
