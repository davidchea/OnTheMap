//
//  UIViewController+logOut.swift
//  OnTheMap
//
//  Created by David Chea on 03/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: Actions
    
    /// Back to previous screen.
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Methods
    
    /// Configure the activity indicator view.
    func loading(_ loading: Bool, activityIndicatorView: UIActivityIndicatorView) {
        if loading {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}
