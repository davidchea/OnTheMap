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
    
    func setViewData(dataCodable: Results) {
        tableActivityIndicatorView.stopAnimating()
        
        StudentLocationData.allStudentLocation = dataCodable.results
        studentLocationTableView.reloadData()
    }
    
    func refresh() {
        StudentLocationData.allStudentLocation.removeAll()
        studentLocationTableView.reloadData()
        
        setViewData()
    }
}
