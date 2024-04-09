//
//  TabViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by James MacAloney on 2024-04-08.
//

import UIKit

class TabViewController: UITabBarController {

    var userId: Int64?
    var userFirstName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // This method is used to pass data from the LoginViewController to this TabViewController
    func setUserData(userId: Int64, userFirstName: String) {
        self.userId = userId
        self.userFirstName = userFirstName
        print("TAB User ID: \(userId)")
        print("TAB User First Name: \(userFirstName)")
    }
}
