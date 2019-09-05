//
//  TableViewController.swift
//  OnTheMap
//
//  Created by David Chea on 05/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var studentLocationTableView: UITableView!
    @IBOutlet weak var tableActivityIndicatorView: UIActivityIndicatorView!

    @IBAction func refresh(_ sender: UIBarButtonItem) {
        refresh()
    }
}

extension TableViewController: DataSetting {
    
    func setViewData() {
        tableActivityIndicatorView.startAnimating()
        UdacityAPI.getAllStudentLocation(completion: setViewData(dataCodable:))
    }
    
    func setViewData(dataCodable: Results) {
        tableActivityIndicatorView.stopAnimating()
        
        StudentLocationData.setAllStudentLocation(allStudentLocation: dataCodable.results)
        studentLocationTableView.reloadData()
    }
    
    func refresh() {
        StudentLocationData.allStudentLocation.removeAll()
        studentLocationTableView.reloadData()
        
        setViewData()
    }
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentLocationData.allStudentLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentLocationCell", for: indexPath)
        let studentLocation = StudentLocationData.allStudentLocation[indexPath.row]
        
        cell.textLabel!.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        cell.detailTextLabel!.text = studentLocation.mediaURL
        
        return cell
    }
}
