//
//  StudentLocationTableViewController.swift
//  OnTheMap
//
//  Created by David Chea on 03/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit

class StudentLocationTableViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var studentLocationTableView: UITableView!
    @IBOutlet weak var studentLocationTableActivityIndicatorView: UIActivityIndicatorView!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading(true, activityIndicatorView: studentLocationTableActivityIndicatorView)
        UdacityAPI.getStudentLocationData(completion: fillStudentLocationData(dataCodable:))
    }
    
    // MARK: Actions
    
    /// Refresh the `StudentLocation` list.
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        // Clear all data
        StudentLocationData.studentLocationData.removeAll()
        studentLocationTableView.reloadData()
        
        // Set new data
        loading(true, activityIndicatorView: studentLocationTableActivityIndicatorView)
        UdacityAPI.getStudentLocationData(completion: fillStudentLocationData(dataCodable:))
    }
    
    // MARK: Methods
    
    /**
     Fill the `StudentLocation` array.
     
     - Parameter dataCodable: The data send by the Udacity API to get the most recent 100 `StudentLocation`.
     */
    func fillStudentLocationData(dataCodable: Results) {
        loading(false, activityIndicatorView: studentLocationTableActivityIndicatorView)
        StudentLocationData.studentLocationData = dataCodable.results
        studentLocationTableView.reloadData()
    }
}

extension StudentLocationTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentLocationData.studentLocationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentLocationCell", for: indexPath)
        let studentLocation = StudentLocationData.studentLocationData[indexPath.row]
        
        cell.textLabel!.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        cell.detailTextLabel!.text = studentLocation.mediaURL
        
        return cell
    }
}
