//
//  TabViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by James MacAloney on 2024-04-08.
//
//  James MacAloney 101362896

import UIKit

class TabViewController: UITabBarController {

    var userId: Int64?
    var userFirstName: String?
    
    var listsTableViewController: ListsTableViewController?
    var newListController: NewListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ensure setUserData method is called with the correct values
        if let userId = userId, let userFirstName = userFirstName {
            setUserData(userId: userId, userFirstName: userFirstName)
        } else {
            print("User ID or First Name is nil in TabViewController")
        }
    }

    // This method is used to pass data from the LoginViewController to this TabViewController
    func setUserData(userId: Int64, userFirstName: String) {
        self.userId = userId
        self.userFirstName = userFirstName
        
        // Pass data to child view controllers
        if let listsVC = viewControllers?.first as? ListsTableViewController {
            listsVC.userId = userId
            listsVC.userFirstName = userFirstName
            /*
            print("in tab setting list User ID: \(userId)")
            print("in tab setting list User First Name: \(userFirstName)")
             */
        }
        
        if let newListVC = viewControllers?[1] as? NewListViewController {
            newListVC.userId = userId
            newListVC.userFirstName = userFirstName
            /*
            print("in tab setting newlist User ID: \(userId)")
            print("in tab setting newlist User First Name: \(userFirstName)")
             */
        } else {
            print("NewListViewController not found")
        }
        
        print("TAB User ID: \(userId)")
        print("TAB User First Name: \(userFirstName)")
    }

}
