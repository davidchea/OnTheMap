//
//  ViewController.swift
//  OnTheMap
//
//  Created by David Chea on 28/08/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpTextView: UITextView!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSignUpTextView()
        subscribeToKeyboardNotifications()
    }
    
    // MARK: Actions
    
    @IBAction func logIn(_ sender: Any) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let login = Login(username: emailTextField.text!, password: passwordTextField.text!)
        let udacity = Udacity(udacity: login)
        let udacityJson = try! JSONEncoder().encode(udacity)
        request.httpBody = udacityJson
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "successfulLogin", sender: nil)
            }
        }
        task.resume()
    }
    
    // MARK: Methods
    
    /// Set the sign up link and center the text view.
    func setSignUpTextView() {
        let attributedString = NSMutableAttributedString(string: signUpTextView.text!)
        let url = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated")!
    
        // Set the "Sign up." substring to be the link
        attributedString.setAttributes([.link: url], range: NSMakeRange(23, 8))
        
        signUpTextView.attributedText = attributedString
        signUpTextView.textAlignment = NSTextAlignment.center
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
}
