//
//  ItemListViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by Vincent Calonzo on 2024-04-15.
//

import UIKit

class ItemTableViewCell: UITableViewCell{
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCategory: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
}


struct Item {
    let name: String
    let category: String
    let price: Double
}


class ItemListViewController: UIViewController {
    
    var listID: Int64! = nil
    var listName: String! = nil
    var data: [Item] = []
    let db = Database()
    var priceValue: Double = 0

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var ItemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ItemTableView.delegate = self
        ItemTableView.dataSource = self
        
        if let listName = listName {
            print("list name: \(listName)")
            listNameLabel.text = listName
        }
        
        if let listID = listID {
                fetchItemFromList(listId: listID)
        } else {
            print("listID is nil")
        }
    }
    
    private func fetchItemFromList(listId: Int64){
        if let products = db.getProductsForList(listID: listId) {
            for product in products {
                
                let item = Item(name: product.name, category: product.category, price: product.price)
                
                priceValue += item.price
                
                data.append(item)
            }
        }
        
        let stringPriceValue = String(format: "Total Price: $%.2f", priceValue)
        totalPrice.text = stringPriceValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? AddProductViewController{
            dest.listID = listID
            dest.listName = listName
        }
    }

}

extension ItemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
}

extension ItemListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        
        
        let item = data[indexPath.row]
        
        let strPrice = String(format: "%.2f",item.price)
        
        cell.itemName.text = item.name
        cell.itemCategory.text = item.category
        cell.itemPrice.text = "$\(strPrice)"
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}
