//
//  LoginViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by Stefan Kepinski on 2024-03-24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailEntry: UITextField!
    
    @IBOutlet weak var PassEntry: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var LoginFailedLabel: UILabel!
    
    var userId: Int64?
    var userFirstName: String?
    
    override func viewDidLoad() {
            super.viewDidLoad()
            LoginFailedLabel.isHidden = true
            PassEntry.isSecureTextEntry = true
        }
        
        @IBAction func loginPressed(_ sender: UIButton) {
            guard let email = EmailEntry.text, !email.isEmpty,
                  let password = PassEntry.text, !password.isEmpty else {
                LoginFailedLabel.text = "Please enter both email and password"
                LoginFailedLabel.isHidden = false
                return
            }

            let database = Database()
                    if let userData = database.getUser(email: email, password: password) {
                        userId = userData.id
                        userFirstName = userData.firstName
                        performSegue(withIdentifier: "loginToListsSegue", sender: self)
                    } else {
                        LoginFailedLabel.isHidden = false
                    }
                }
                
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "loginToListsSegue" {
                    if let destinationVC = segue.destination as? TabViewController {
                        destinationVC.userId = userId
                        destinationVC.userFirstName = userFirstName
                    }
                }
            }

}
