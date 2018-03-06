//
//  FirstStartController.swift
//  MyMenu
//
//  Created by Isaac Rand (student LM) on 2/26/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit

class FirstStartController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var tableView: UITableView!
    let categories: [String] = ["Dairy", "Vegetables & Legumes", "Fruits", "Baking & Grains", "Protein", "Condiment", "Oils, Seasonings, & Sauces", "Beverages", "Soup", "Nuts", "Desserts & Snack"]
    var open: [Bool] = [true, false, false, false, false, false, false, false, false, false, false,]
    
    
    override func viewDidLoad() {
        
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "cellID")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! CategoryCell
        
        cell.category = indexPath.row
        cell.categoryLabel.text = categories[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CategoryCell
        
        // Already open
        if open[indexPath.row] {
            UIView.animate(withDuration: 1, animations: {
                tableView.rowHeight = 50
                cell.tableView.isHidden = true
                cell.arrowImage.transform = cell.arrowImage.transform.rotated(by: CGFloat(Double.pi/2))
                self.open[indexPath.row] = false
            })
        } else {
            UIView.animate(withDuration: 1, animations: {
                tableView.rowHeight = CGFloat(cell.ingredients[indexPath.row].count*50+50)
                cell.tableView.isHidden = false
                cell.arrowImage.transform = cell.arrowImage.transform.rotated(by: CGFloat(Double.pi/2))
                self.open[indexPath.row] = true
            })
        }
        
    }
    
    
}
