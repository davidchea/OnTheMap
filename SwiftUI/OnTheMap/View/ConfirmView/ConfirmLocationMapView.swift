//
//  ConfirmLocationMapView.swift
//  OnTheMap
//
//  Created by David Chea on 11/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI
import MapKit

struct ConfirmLocationMapView: UIViewRepresentable {
    
    // MARK: - Properties
    
    let locality: String!
    let coordinate: CLLocationCoordinate2D!
    
    // MARK: - Protocol methods
    
    func makeUIView(context: Context) -> MKMapView {
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = locality
        pointAnnotation.coordinate = coordinate
        
        let coordinateRegion = MKCoordinateRegion(center: pointAnnotation.coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000)
        
        let mapView = MKMapView()
        mapView.addAnnotation(pointAnnotation)
        mapView.setRegion(coordinateRegion, animated: true)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
}
