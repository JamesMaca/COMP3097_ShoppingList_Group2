//
//  NewListViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by James MacAloney on 2024-04-08.
//

import UIKit

class NewListViewController: UIViewController {
    
    @IBOutlet weak var newListName: UITextField!
    
    @IBOutlet weak var CreateList: UIButton!
    let db = Database()
    weak var listsTableViewController: ListsTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createList(_ sender: UIButton) {
        guard let listName = newListName.text, !listName.isEmpty else {
            print("list name empty")
            return
        }
        
        let userID: Int64 = 123
        
        if db.addList(userID: userID, listName: listName){
            print("List added")
            listsTableViewController?.tableView.reloadData()
            dismiss(animated: true, completion: nil)
        }else{
            print("Failed to add list")
        }
        
    }
    
}
