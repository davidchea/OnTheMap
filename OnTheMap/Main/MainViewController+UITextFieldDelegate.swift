//
//  TextFieldDelegate.swift
//  OnTheMap
//
//  Created by David Chea on 02/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit

extension MainViewController: UITextFieldDelegate {
    
    // MARK: Delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        
        return true
    }
}
