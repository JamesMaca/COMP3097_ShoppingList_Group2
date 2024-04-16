//
//  ProductTabViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by Vincent Calonzo on 2024-04-16.
//

import UIKit

class ProductTabViewController: UITabBarController {
    
    var userID: Int64!
    var listID: Int64!
    var listName: String!
    
    var ItemListViewController: ItemListViewController?
    var AddProductViewController: AddProductViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userID = userID, let listID = listID, let listName = listName {
            print("ProductTabViewController")
            test(userid: userID, listid: listID, listname: listName)
        }
        
    }
    
    func test(userid: Int64, listid: Int64, listname: String) {
    
        if let itemListVC = viewControllers?.first as? ItemListViewController {
            itemListVC.listID = listid
            itemListVC.listName = listname
        }
    }

}
