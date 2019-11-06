//
//  TableViewController+DataSetting.swift
//  OnTheMap
//
//  Created by David Chea on 06/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

extension TableViewController: DataSetting {
    
    // MARK: Protocol methods
    
    func setViewData() {
        tableActivityIndicatorView.startAnimating()
        UdacityAPI.getAllStudentLocation(completionHandler: setViewData(dataCodable:))
    }
    
    func setViewData(dataCodable: Results?) {
        tableActivityIndicatorView.stopAnimating()
        
        guard let dataCodable = dataCodable else {
            displayAlert(title: "Internal error", message: "An error occurred, please try again later.")
            
            return
        }
        
        // Set all the StudentLocation
        StudentLocationData.allStudentLocation = dataCodable.results
        
        // Refresh the table view
        studentLocationTableView.reloadData()
    }
    
    func refresh() {
        StudentLocationData.allStudentLocation.removeAll()
        studentLocationTableView.reloadData()
        
        setViewData()
    }
}
