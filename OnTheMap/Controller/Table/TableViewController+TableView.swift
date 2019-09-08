//
//  TableViewController+TableView.swift
//  OnTheMap
//
//  Created by David Chea on 06/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Delegate methods
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentLocationURL = StudentLocationData.allStudentLocation[indexPath.item].mediaURL
        
        guard let url = URL(string: studentLocationURL) else {
            displayAlert(title: "Invalid URL", message: "")
            
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
