//
//  ListsTableViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by James MacAloney on 2024-02-22.
//

//import UIKit
//
//class ListsTableViewController: UITableViewController {
//    
//    var data = [
//                "Recent":["Groceries", "Cleaning", "Birthday Supplies"],
//                "Last Week": ["Groceries", "Errand"]
//                ]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return data.keys.count
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        
//        let k = Array(data.keys)[section]
//        
//        return data[k]!.count
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "list_cell", for: indexPath)
//        let k = Array(data.keys)[indexPath.section]
//        let d = data[k]!
//        cell.textLabel?.text = d[indexPath.row]
//        
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let k = Array(data.keys)[section]
//        return k
//    }
//
//}

import UIKit

class ListsTableViewController: UITableViewController {
    
    var listNames: [String] = []
    let db = Database()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load list names from the database
        if let names = db.getLists() {
            listNames = names
        } else {
            // Handle error if unable to fetch list names
            print("Failed to fetch list names")
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list_cell", for: indexPath)
        cell.textLabel?.text = listNames[indexPath.row]
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewList" {
            if let newListVC = segue.destination as? NewListViewController {
                newListVC.listsTableViewController = self
            }
        }
    }

}
