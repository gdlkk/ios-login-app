//
//  ViewController.swift
//  LoginApp
//
//  Created by Mateusz Dettlaff on 25/05/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let dummyDatabase = [User(username: "admin", password: "password")]
    
    private let validation: ValidationService
    
    init(validation: ValidationService) {
        self.validation = validation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.validation = ValidationService()
        super.init(coder: coder)
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        do {
            let username = try validation.validateUsername(usernameTextField.text)
            let password = try validation.validatePassword(passwordTextField.text)
            
            
            // Login to database...
            if let user = dummyDatabase.first(where: { user in
                user.username == username && user.password == password
            }) {
                presentAlert(with: "You successfully logged in as \(user.username)")
                
            } else {
                throw LoginError.invalidCredentials
            }
            
        } catch {
            present(error)
        }
    }
}

extension ViewController {
    enum ValidationError: LocalizedError {
        case invalidValue
        case passwordTooLong
        case passwordTooShort
        case usernameTooLong
        case usernameTooShort
        
        var errorDescription: String? {
            switch self {
            case .invalidValue:
                return "You have entered an invalid value."
            case .passwordTooLong:
                return "Your password is too long."
            case .passwordTooShort:
                return "Your password is too short."
            case .usernameTooLong:
                return "Your username is too long."
            case .usernameTooShort:
                return "Your username is too short."
            }
        }
    }
    
    enum LoginError: LocalizedError {
        case invalidCredentials
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return "Incorrect username or password. Please try again."
            }
        }
    }
}


