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
    
    // MARK: Properties
    
    var isKeyboardShown = false
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSignUpTextView()
        setTapGestureRecognizer()
        subscribeToKeyboardNotifications()
    }
    
    // MARK: Actions
    
    /// Check email and password with Udacity API then log in.
    @IBAction func logIn(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        // Display an alert if email and/or password text fields are empty
        guard !email.isEmpty, !password.isEmpty else {
            let alertController = UIAlertController(title: "Empty field", message: "Please fill email and password fields.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        // Get the session endpoint and create the request
        var request = URLRequest(url: UdacityAPI.Endpoint.session.url)
        
        // Set values to the request
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Set email and password to the request
        let login = Login(username: email, password: password)
        let udacity = Udacity(udacity: login)
        let udacityJson = try! JSONEncoder().encode(udacity)
        request.httpBody = udacityJson
        
        // Check if it is correct email and password then log in
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            // The first five characters are used for security purpose, need to skip them
            let newData = data.subdata(in: 5..<data.count)
            let dataJson = try! JSONSerialization.jsonObject(with: newData, options: []) as! [String: Any]
            
            // Display an alert if email and/or password are incorrect
            DispatchQueue.main.async {
                if (dataJson["error"] == nil) {
                    self.performSegue(withIdentifier: "successfulLogin", sender: nil)
                } else {
                    let alertController = UIAlertController(title: "Login failed", message: "Incorrect email and/or password.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        task.resume()
    }
    
    // MARK: Methods
    
    /// Set the sign up link and center the text view.
    func setSignUpTextView() {
        guard
            let signUpText = signUpTextView.text,
            let url = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated") else {
                return
            }
        
        let attributedString = NSMutableAttributedString(string: signUpText)
    
        // Set the "Sign up." substring to be the link
        attributedString.setAttributes([.link: url], range: NSMakeRange(23, 8))
        
        signUpTextView.attributedText = attributedString
        signUpTextView.textAlignment = NSTextAlignment.center
    }
    
    /// Hide the keyboard when the user taps outside of a text field.
    func setTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    /// Release text fields focus so the keyboard will be hidden.
    @objc func hideKeyboard (_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    /// Subscribe to keyboard notifications.
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Move the view when email or password text field is tapped.
    @objc func keyboardWillShow(_ sender: Notification) {
        guard !isKeyboardShown else { return }
        
        view.frame.origin.y -= getKeyboardHeight(notification: sender)
        isKeyboardShown = true
    }
    
    /// Set the view to its original position.
    @objc func keyboardWillHide(_ sender: Notification) {
        view.frame.origin.y = 0
        isKeyboardShown = false
    }
    
    /// Get keyboard height in order to move the view.
    func getKeyboardHeight(notification: Notification) -> CGFloat {
        guard let userInfo = notification.userInfo else { return 0 }
        
        let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
}
