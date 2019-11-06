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

    // MARK: Outlets
    
    @IBOutlet weak var studentLocationMapView: MKMapView!
    @IBOutlet weak var mapActivityIndicatorView: UIActivityIndicatorView!
    
    // MARK: Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setViewData()
    }
    
    // MARK: Actions
    
    /// Refresh the map view.
    @IBAction func refreshAction() {
        refresh()
    }
}
