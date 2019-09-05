//
//  DataSetting.swift
//  OnTheMap
//
//  Created by David Chea on 05/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

protocol DataSetting {
    
    func setViewData()
    
    /**
     Set `StudentLocationData` and the current view data (`MKMapView` or `UITableView`).
     
     - Parameter dataCodable: The data send by the Udacity API to get the most recent 100 `StudentLocation`.
     */
    func setViewData(dataCodable: Results)
    
    func refresh()
}
