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
    
    /// Check email and password with Udacity API then log in.
    @IBAction func logIn(_ sender: Any) {
        // Get endpoint and create the request
        var request = URLRequest(url: UdacityAPI.Endpoint.session.url)
        
        // Set values to the request
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Set email and password to the request
        let login = Login(username: emailTextField.text!, password: passwordTextField.text!)
        let udacity = Udacity(udacity: login)
        let udacityJson = try! JSONEncoder().encode(udacity)
        request.httpBody = udacityJson
        
        // Check if it is correct email and password then log in
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            // The first five characters are used for security purpose, need to skip them
            let newData = data.subdata(in: 5..<data.count)
            let dataJson = try! JSONSerialization.jsonObject(with: newData, options: []) as! [String: Any]
            
            if (dataJson["error"] == nil) {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "successfulLogin", sender: nil)
                }
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
    
    /// Subscribe to keyboard notifications.
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Move the view when email or password text field is touched.
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    /// Set the view to its original position.
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    /// Get keyboard height in order to move the view.
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
}
