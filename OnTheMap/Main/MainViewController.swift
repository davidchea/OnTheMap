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
    @IBOutlet weak var loginActivityIndicatorView: UIActivityIndicatorView!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSignUpTextView()
        setTapGestureRecognizer()
    }
    
    // MARK: Actions
    
    /// Check email and password with Udacity API then log in.
    @IBAction func logIn(_ sender: Any) {
        // Display an alert if email and/or password text fields are empty
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty
        else {
            displayAlert(title: "Empty field", message: "Please fill email and password fields.")
            
            return
        }
        
        loggingIn(true)
        
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
                    self.displayAlert(title: "Login failed", message: "Incorrect email and/or password.")
                }
                
                self.loggingIn(false)
            }
        }
        task.resume()
    }
    
    // MARK: Methods
    
    /// Set the sign up link and center the text view.
    func setSignUpTextView() {
        guard
            let signUpText = signUpTextView.text,
            let url = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated")
        else { return }
        
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
    
    /// Display a custom alert box.
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    /// Start or stop animating the activity indicator view when the login is processing or has finished to process.
    func loggingIn(_ loggingIn: Bool) {
        if loggingIn {
            loginActivityIndicatorView.startAnimating()
        } else {
            loginActivityIndicatorView.stopAnimating()
        }
    }
}
