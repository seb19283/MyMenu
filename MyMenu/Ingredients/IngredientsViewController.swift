//
//  IngredientsViewController.swift
//  MyMenu
//
//  Created by Sebastian Connelly (student LM) on 2/26/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase

class IngredientsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var navigationBar: UINavigationItem!
    
    var ingredients: [[String]] = [[String]]()
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        tableView.register(IngredientCell.self, forCellReuseIdentifier: "cellID")
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        navigationBar.leftBarButtonItem = nil
        
        getIngredients()
    }
    
    @objc func addButtonClicked(){
        
    }
    
    func getIngredients(){
        ref.child((UIDevice.current.identifierForVendor?.uuidString)!).child("Ingredients").observe(.value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String:[String]] {
                
                for (_, ingredient) in dictionary{
                    self.ingredients.append(ingredient)
                }
                
            }
            
        }, withCancel: nil)
    }
    
    @IBAction func editButtonClicked(_ sender: UIBarButtonItem) {
        
        navigationBar.leftBarButtonItem = cancelButton
        navigationBar.rightBarButtonItem = addButton
        editButton.isEnabled = false
        tableView.isEditing = true
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        
        editButton.isEnabled = true
        tableView.isEditing = false
        navigationBar.rightBarButtonItem = editButton
        navigationBar.leftBarButtonItem = nil
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! IngredientCell
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeAction = UISwipeActionsConfiguration()
        
        return swipeAction
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeAction = UISwipeActionsConfiguration()
        
        return swipeAction
    }
    
}

//TableViewCell class
class IngredientCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
