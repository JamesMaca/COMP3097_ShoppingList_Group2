//
//  ListsTableViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by James MacAloney on 2024-02-22.
//
import UIKit

class ListsTableViewController: UITableViewController {
    
    
    //var listNames: [String] = []
    
    var listData: [(id: Int64, name: String)] = []

    
    let db = Database()
    var userId: Int64?
    var userFirstName: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchLists() // Fetch the lists each time the view appears
    }
    
    /*
    private func fetchLists() {
        if let userId = userId {
            // Load list names for the current user from the database
            if let names = db.getLists(forUserID: userId) {
                listNames = names
                tableView.reloadData()
            } else {
                // Handle error if unable to fetch list names
                print("Failed to fetch list names")
            }
            
            print("LISTS User ID: \(userId)")
        } else {
            print("User ID is nil")
        }
    }*/
    
    private func fetchLists() {
        if let userId = userId {
            // Load list names and IDs for the current user from the database
            if let lists = db.getLists(forUserID: userId) {
                listData = lists
                tableView.reloadData()
            } else {
                // Handle error if unable to fetch list names
                print("Failed to fetch list names")
            }
            
            print("LISTS User ID: \(userId)")
        } else {
            print("User ID is nil")
        }
    }

    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return listNames.count
        
        return listData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list_cell", for: indexPath)
        
        let list = listData[indexPath.row]
        
        //cell.textLabel?.text = listNames[indexPath.row]
        cell.textLabel?.text = list.name
        
        return cell
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewList" {
            if let newListVC = segue.destination as? NewListViewController {
                newListVC.listsTableViewController = self
            }
        }
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = tableView.indexPathForSelectedRow!
        
        let item = listData[index.row]
        
        if let dest = segue.destination as? ItemListViewController {
            
            dest.listID = item.id
            dest.listName = item.name
        }
    }
}
