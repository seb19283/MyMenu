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
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var navigationBar: UINavigationItem!
    
    var ingredients = [ExpandableNames]()
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    var cancelButton: UIBarButtonItem!
    var deleteButton: UIBarButtonItem!
    var categories = [String]()
    var selectedIndexPaths = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(r: 150, g: 199, b: 149)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.allowsMultipleSelectionDuringEditing = true
        
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
        deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteButtonClicked))
        deleteButton.tintColor = .red
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getCategories { (names, category) in
            self.categories.append(category)
            self.ingredients.append(ExpandableNames(isExpanded: false, names: names))
            self.tableView.reloadData()
        }
    }
    
    func getCategories(success: @escaping ([String], String) -> Void){
        
        ingredients.removeAll()
        categories.removeAll()
        
        ref.child("Test").child("Ingredients").observe(.childAdded, with: { (snapshot) in
            
            var names = [String]()
            
            for item in snapshot.children {
                if let item = item as? DataSnapshot {
                    if let ingredient = item.value as? String {
                        names.append(ingredient)
                    }
                }
            }
            
            success(names, snapshot.key)
            
        }, withCancel: nil)
        
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "Add", sender: nil)
        
    }
    
    @IBAction func editButtonClicked(_ sender: UIBarButtonItem) {
        
        navigationBar.leftBarButtonItem = cancelButton
        navigationBar.rightBarButtonItem = deleteButton
        deleteButton.isEnabled = false
        tableView.isEditing = true
        
    }
    
    @objc func deleteButtonClicked() {
        self.alertMessage("Do you want to add these ingredients to your grocery list?", indexPaths: selectedIndexPaths)
        selectedIndexPaths.removeAll()
        deleteButton.title = "Delete"
        deleteButton.isEnabled = false
        tableView.reloadData()
    }
    
    @objc func cancelButtonClicked() {
        
        tableView.isEditing = false
        navigationBar.rightBarButtonItem = addButton
        navigationBar.leftBarButtonItem = editButton
        selectedIndexPaths.removeAll()
        deleteButton.title = "Delete"
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndexPaths.append(indexPath)
        
        if !deleteButton.isEnabled {
            deleteButton.isEnabled = true
        }
        
        deleteButton.title = "Delete(\(selectedIndexPaths.count))"
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        selectedIndexPaths.remove(at: selectedIndexPaths.index(of: indexPath)!)
        
        if selectedIndexPaths.count == 0 {
            deleteButton.isEnabled = false
            deleteButton.title = "Delete"
        } else {
            deleteButton.title = "Delete(\(selectedIndexPaths.count))"
        }
        
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
        
        if tableView.isEditing, selectedIndexPaths.contains(indexPath) {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.backgroundColor = UIColor(r: 150, g: 199, b: 149)
        
        let categoryLabel: UILabel = {
            let label = UILabel()
            label.text = categories[section]
            label.textColor = UIColor(r: 60, g: 32, b: 35)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: "HelveticaNeue", size: 16)
            return label
        }()
        
        let arrowImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        let separatorView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(r: 237, g: 213, b: 214)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        view.addSubview(separatorView)
        separatorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        separatorView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(arrowImageView)
        arrowImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        arrowImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 1).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        view.addSubview(categoryLabel)
        categoryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        categoryLabel.rightAnchor.constraint(equalTo: arrowImageView.leftAnchor).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 1).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 1).isActive = true
        
        view.tag = section
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expandHeader(sender:))))
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            
            // Create an alert that prompts the user whether they want to add to grocery list or not
            self.alertMessage("Do you want to add this ingredient to your grocery list?", indexPaths: [indexPath])
            
        }
        
        let groceryListAction = UIContextualAction(style: .normal, title: "Add To Grocery List") { (action, view, handler) in
            
            let i = self.ingredients[indexPath.section].names[indexPath.row]
            
            self.ref.child("Test").child("Grocery List").child(self.categories[indexPath.section]).child(i).setValue(i)
            tableView.setEditing(false, animated: true)
        }
        
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, groceryListAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func alertMessage(_ message: String, indexPaths: [IndexPath]){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let YES = UIAlertAction(title: "Yes", style: .default) { (action) in
            
            for indexPath in indexPaths {
                let i = self.ingredients[indexPath.section].names.remove(at: indexPath.row)
                
                self.ref.child("Test").child("Grocery List").child(self.categories[indexPath.section]).child(
                    "\(i)").setValue(i)
                
                if self.ingredients[indexPath.section].names.count == 0 {
                    self.ref.child("Test").child("Ingredients").child(self.categories[indexPath.section]).removeValue()
                    self.categories.remove(at: indexPath.section)
                    self.ingredients.remove(at: indexPath.section)
                } else {
                    self.ref.child("Test").child("Ingredients").child(self.categories[indexPath.section]).child("\(i)").removeValue()
                }
                
                self.tableView.reloadData()
            }
            
        }
        let NO = UIAlertAction(title: "No", style: .default) { (action) in
            
            for indexPath in indexPaths {
                let i = self.ingredients[indexPath.section].names.remove(at: indexPath.row)
                
                if self.ingredients[indexPath.section].names.count == 0 {
                    self.ref.child("Test").child("Ingredients").child(self.categories[indexPath.section]).removeValue()
                    self.categories.remove(at: indexPath.section)
                    self.ingredients.remove(at: indexPath.section)
                } else {
                    self.ref.child("Test").child("Ingredients").child(self.categories[indexPath.section]).child("\(i)").removeValue()
                }
                
                self.tableView.reloadData()
            }
            
        }
        
        alert.addAction(YES)
        alert.addAction(NO)
        
        self.present(alert, animated: true, completion:{
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
        
    }
    
    @objc func alertControllerBackgroundTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? UINavigationController, let targetVC = destinationVC.topViewController as? AddIngredientsViewController {
            targetVC.startController = "Ingredients"
        }
    }
    
}
