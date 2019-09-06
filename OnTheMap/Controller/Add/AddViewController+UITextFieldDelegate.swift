//
//  AddViewController+UITextFieldDelegate.swift
//  OnTheMap
//
//  Created by David Chea on 07/09/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit

extension AddViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == locationTextField {
            urlTextField.becomeFirstResponder()
        }
        
        return true
    }
}
