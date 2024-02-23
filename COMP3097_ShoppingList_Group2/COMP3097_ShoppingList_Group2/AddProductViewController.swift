//
//  AddProductViewController.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by Vincent Calonzo on 2024-02-23.
//

import UIKit

class AddProductViewController: UIViewController {
    
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet var selectionArr: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showButtonVisibility() {
        selectionArr.forEach { button in
            button.isHidden = !button.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func selectButtonAction(_ sender: UIButton) {
        showButtonVisibility()
    }
    
    @IBAction func selectionArrAction(_ sender: UIButton){
        showButtonVisibility()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
