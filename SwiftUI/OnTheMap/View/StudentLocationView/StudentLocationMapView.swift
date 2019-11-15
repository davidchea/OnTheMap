//
//  StudentLocationMapView.swift
//  OnTheMap
//
//  Created by David Chea on 09/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI
import MapKit

struct StudentLocationMapView: UIViewRepresentable {
    
    // MARK: - Property
    
    @EnvironmentObject private var appData: AppData
    
    // MARK: - Protocol methods
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let newAnnotations = appData.allStudentLocation.map { StudentLocationAnnotation(studentLocation: $0) }
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(newAnnotations)
    }
}
