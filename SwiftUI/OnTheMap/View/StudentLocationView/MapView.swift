//
//  MapView.swift
//  OnTheMap
//
//  Created by David Chea on 09/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    // MARK: - Property
    
    @EnvironmentObject private var data: Data
    
    // MARK: - Protocol methods
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.addAnnotations(data.allPointAnnotation)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
}
