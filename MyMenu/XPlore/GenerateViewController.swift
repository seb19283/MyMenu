//
//  GenerateViewController.swift
//  MyMenu
//
//  Created by Sebastian Connelly (student LM) on 3/20/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit

class GenerateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var userIngredients = [[String]]()
    var recipes: [RecipeEdamam]?
    var recipe: RecipeEdamam?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(RecipeCell.self, forCellReuseIdentifier: "cellID")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(r: 108, g: 188, b: 128)
        tableView.tableFooterView = UIView()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let r = recipes {
            return r.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let r = recipes?[indexPath.row] else {return}
        
        recipe = r
        
        performSegue(withIdentifier: "Recipe", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let recipe = recipes?[indexPath.row] else { fatalError() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! RecipeCell
        
        cell.backgroundColor = .clear
        cell.titleLabel.text = recipe.title
        cell.descriptionLabel.text = "Yield: \(recipe.yield) \nDescription: \(recipe.tags)"
        cell.recipeImageView.image = recipe.image
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RecipeViewController, let r = recipe {
            destination.recipe = r
        }
    }
    
}
