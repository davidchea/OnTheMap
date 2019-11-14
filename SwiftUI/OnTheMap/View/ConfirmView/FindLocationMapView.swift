//
//  FindLocationMapView.swift
//  OnTheMap
//
//  Created by David Chea on 11/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI
import MapKit

struct FindLocationMapView: UIViewRepresentable {
    
    // MARK: - Protocol methods
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
}
