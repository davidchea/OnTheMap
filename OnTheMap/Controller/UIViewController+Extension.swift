//
//  UIViewController+Extension.swift
//  OnTheMap
//
//  Created by David Chea on 05/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: Actions
    
    /// Dismiss the view controller that was presented modally by the view controller.
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Methods
    
    /// Hide the keyboard when the user taps outside of a text field.
    func setTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    /// Release text fields focus so the keyboard will be hidden.
    @objc func hideKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /// Display a custom alert box.
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
