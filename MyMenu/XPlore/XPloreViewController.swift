//
//  XPloreViewController.swift
//  MyMenu
//
//  Created by Sebastian Connelly (student LM) on 4/4/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit

class XPloreViewController: UIViewController, RecipeRequirementViewControllerDelegate {
    
    func controller(_ controller: RecipeRequirementsViewController, didFindRecipes recipes: [RecipeEdamam]) {
        self.recipes = recipes
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "recipes", sender: self)
        }
        
    }
    
    
    var recipes: [RecipeEdamam]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func goToRecipes() {
        performSegue(withIdentifier: "recipes", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GenerateViewController {
            destination.recipes = recipes
        } else if let vc = segue.destination as? RecipeRequirementsViewController {
            vc.delegate = self
        }
    }
    
}
