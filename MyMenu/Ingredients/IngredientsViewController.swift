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
    
    var ingredients = [ExpandableNames]()
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    var addButton: UIBarButtonItem!
    var categories = [String]()
    var open: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.dataSource = self
        tableView.delegate = self
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        navigationBar.leftBarButtonItem = nil
        
        getCategories()
    }
    
    @objc func addButtonClicked(){
        
    }
    
    func getCategories(){
        ref.child((UIDevice.current.identifierForVendor?.uuidString)!).child("Ingredients").observe(.childAdded, with: { (snapshot) in
            
            let category = snapshot.key
            self.categories.append(category)
            
            
            
            
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
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ingredients[section].isExpanded {
            return ingredients[section].names.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! UITableViewCell
        cell.textLabel?.text = ingredients[indexPath.section].names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.backgroundColor = UIColor.lightGray
        
        let categoryLabel: UILabel = {
            let label = UILabel()
            label.text = categories[section]
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: "Helvetica Neue", size: 16)
            return label
        }()
        
        let arrowImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        view.addSubview(arrowImageView)
        arrowImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        arrowImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(categoryLabel)
        categoryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        categoryLabel.rightAnchor.constraint(equalTo: arrowImageView.leftAnchor).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.tag = section
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expandHeader(sender:))))
        
        return view
    }
    
    @objc func expandHeader(sender: UITapGestureRecognizer){
        
        guard let section = sender.view?.tag else {
            return
        }
        
        var indexPaths = [IndexPath]()
        for row in ingredients[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = ingredients[section].isExpanded
        ingredients[section].isExpanded = !isExpanded
        
        if(isExpanded){
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
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
