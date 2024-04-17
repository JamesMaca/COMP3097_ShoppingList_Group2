//
//  ProductTabViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by Vincent Calonzo on 2024-04-16.
//
//
//  Vincent Nhar Calonzo | 101272540

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
            setup(userid: userID, listid: listID, listname: listName)
        }
        
    }
    
    func setup(userid: Int64, listid: Int64, listname: String) {
    
        if let itemListVC = viewControllers?.first as? ItemListViewController {
            print("\(itemListVC)")
            itemListVC.listID = listid
            itemListVC.listName = listname
            //itemlistVC.userID = userid
        }
        
        if let addProductVC = viewControllers?[1] as? AddProductViewController {
            print("\(listid)")
            print("\(listname	)")
            addProductVC.listID = listid
            addProductVC.listName = listname
        }
    }
}
