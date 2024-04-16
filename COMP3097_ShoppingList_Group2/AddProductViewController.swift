//
//  AddProductViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by Vincent Calonzo on 2024-02-23.
//

import UIKit

class AddProductViewController: UIViewController {
    
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productCategory: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    
    
    @IBOutlet weak var btnAddProduct: UIButton!
    
    let db =  Database()
    
    var listID: Int64!
    var listName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productPrice.keyboardType = .numberPad
    
    }
    
    
    @IBAction func onClick(_ sender: Any) {
        print("Add Button Clicked")
        
        guard let name = productName.text, !name.isEmpty else{
            showAlert(message: "Name is required",title: "Error")
            return
        }
        
        guard let category = productCategory.text, !category.isEmpty else{
            showAlert(message: "Category is required",title: "Error")
            return
        }
        
        guard let category = productCategory.text, !category.isEmpty else{
            showAlert(message: "Category is required",title: "Error")
            return
        }
        
        guard let price = productPrice.text, !price.isEmpty else{
            showAlert(message: "Price is required",title: "Error")
            return
        }
        
        guard let priceValue = Double(price) else {
            showAlert(message: "Price should be a numerical value",title: "Error")
            return
        }
        
        
        if let listID = listID {
            if db.addProduct(listID: listID, productName: name, productCategory: category, productPrice: priceValue) {
                print("Product Added")
                
                // Reset text fields
                productName.text = ""
                productCategory.text = ""
                productPrice.text = ""
            } else {
                print("Failed to add product")
            }
        } else {
            print("listID is nil")
        }
    }
    
    func showAlert(message: String, title: String) {
            let alert = UIAlertController(title: "\(title)", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ItemListViewController{
            dest.listID = listID
            dest.listName = listName
        }
    }
    

}
