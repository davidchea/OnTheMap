//
//  MapViewController+MKMapViewDelegate.swift
//  OnTheMap
//
//  Created by David Chea on 06/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import MapKit

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "annotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView!.canShowCallout = true
            annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let url = URL(string: (view.annotation!.subtitle!)!)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
