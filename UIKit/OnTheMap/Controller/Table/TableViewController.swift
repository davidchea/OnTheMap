//
//  TableViewController.swift
//  OnTheMap
//
//  Created by David Chea on 05/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var studentLocationTableView: UITableView!
    @IBOutlet weak var tableActivityIndicatorView: UIActivityIndicatorView!

    // MARK: Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setViewData()
    }
    
    // MARK: Actions
    
    /// Refresh the table view.
    @IBAction func refreshAction() {
        refresh()
    }
}
