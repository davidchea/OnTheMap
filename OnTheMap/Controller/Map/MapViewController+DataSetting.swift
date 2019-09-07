//
//  MapViewController+DataSetting.swift
//  OnTheMap
//
//  Created by David Chea on 06/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

extension MapViewController: DataSetting {
    
    func setViewData() {
        mapActivityIndicatorView.startAnimating()
        UdacityAPI.getAllStudentLocation(completionHandler: setViewData(dataCodable:))
    }
    
    func setViewData(dataCodable: Results) {
        mapActivityIndicatorView.stopAnimating()
        
        StudentLocationData.allStudentLocation = dataCodable.results
        StudentLocationData.setAllStudentLocationPointAnnotation()
        studentLocationMapView.addAnnotations(StudentLocationData.allStudentLocationPointAnnotation)
    }
    
    func refresh() {
        let annotations = studentLocationMapView.annotations
        studentLocationMapView.removeAnnotations(annotations)
        
        setViewData()
    }
}
