//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by David Chea on 28/08/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
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
    
    /// Check email and password using the Udacity API, then log in.
    @IBAction func logIn() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        guard !email.isEmpty, !password.isEmpty else {
            displayAlert(title: "Empty field", message: "Please fill email and password fields.")
            
            return
        }
        
        loginActivityIndicatorView.startAnimating()
        UdacityAPI.addSession(email: email, password: password, completionHandler: handleSessionResponse(jsonData:))
    }
    
    // MARK: Methods
    
    /// Set the sign up link and center the text view.
    func setSignUpTextView() {
        let attributedString = NSMutableAttributedString(string: signUpTextView.text)
    
        // Set the "Sign up." substring to be the link
        let url = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated")!
        attributedString.setAttributes([.link: url], range: NSMakeRange(23, 8))
        
        signUpTextView.attributedText = attributedString
        signUpTextView.textAlignment = NSTextAlignment.center
    }
    
    /**
     Go to `MapViewController` if login was successful or display an alert box if not.
     
     - Parameter jsonData: The JSON response send by the Udacity API to log in.
     */
    func handleSessionResponse(jsonData: [String: Any]?) {
        loginActivityIndicatorView.stopAnimating()
        
        guard let jsonData = jsonData else {
            displayAlert(title: "Internal error", message: "An error occurred, please try again later.")
            
            return
        }
        
        guard jsonData["error"] == nil else {
            displayAlert(title: "Login failed", message: "Incorrect email and/or password.")
            
            return
        }
        
        performSegue(withIdentifier: "successfulLogin", sender: nil)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}
