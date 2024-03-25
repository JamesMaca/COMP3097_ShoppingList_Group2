//
//  RegisterViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by Stefan Kepinski on 2024-03-24.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var FirstNameEntry: UITextField!
    
    @IBOutlet weak var LastNameEntry: UITextField!
    
    @IBOutlet weak var EmailEntry: UITextField!
    
    @IBOutlet weak var PassEntry: UITextField!
    
    @IBOutlet weak var ConfirmPassEntry: UITextField!
    
    @IBOutlet weak var RegisterButton: UIButton!
    
    
    let databaseManager = Database()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            PassEntry.isSecureTextEntry = true
            ConfirmPassEntry.isSecureTextEntry = true
            
        }
        
        @IBAction func registerUser(_ sender: UIButton) {
            
            guard let password = PassEntry.text, let confirmPassword = ConfirmPassEntry.text, password == confirmPassword 
                    else {
                showAlert(title: "Error", message: "Passwords do not match, please try again")
                return
            }
            
            guard let firstName = FirstNameEntry.text, !firstName.isEmpty,
                  let lastName = LastNameEntry.text, !lastName.isEmpty,
                  let email = EmailEntry.text, !email.isEmpty 
                    else {
                showAlert(title: "Error", message: "Please fill in all fields")
                return
            }
            
            let success = databaseManager.addUser(firstName: firstName, lastName: lastName, email: email, password: password)
            
            if success {
                showAlert(title: "Success", message: "Registration Successful!") {
                    self.performSegue(withIdentifier: "registerToLoginSegue", sender: self)
                }
                print("\(firstName) \(lastName) registered")
            } else {
                showAlert(title: "Error", message: "Error registering. Please try again")
                print("Error registering user")
            }
        }
        
        func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in completion?() }))
            self.present(alert, animated: true, completion: nil)
        }
    

}
