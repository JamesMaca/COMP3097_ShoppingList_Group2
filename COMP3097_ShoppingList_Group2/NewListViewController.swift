//
//  NewListViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by James MacAloney on 2024-04-08.
//

import UIKit

class NewListViewController: UIViewController {
    
    var userId: Int64?
    var userFirstName: String?
    
    @IBOutlet weak var newListName: UITextField!
    
    @IBOutlet weak var CreateList: UIButton!
    let db = Database()
    weak var listsTableViewController: ListsTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userId = userId, let userFirstName = userFirstName {
            print("NEW LISTS User ID: \(userId)")
            print("NEW LISTS User First Name: \(userFirstName)")
        } else {
            print("User ID or First Name is nil")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createList(_ sender: UIButton) {
        guard let listName = newListName.text, !listName.isEmpty else {
            print("list name empty")
            return
        }
        
        let userID: Int64 = userId!
        
        if db.addList(userID: userID, listName: listName) {
            print("List added")
            listsTableViewController?.tableView.reloadData() // Refresh the list data
            dismiss(animated: true) {
                if let tabController = self.tabBarController as? TabViewController {
                    // Navigate back to the lists page
                    tabController.selectedIndex = 0
                }
            }
        } else {
            print("Failed to add list")
        }
    }
    
    
    
}
