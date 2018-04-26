//
//  AddIngredientsViewController.swift
//  MyMenu
//
//  Created by Sebastian Connelly (student LM) on 4/3/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddIngredientsViewController: UIViewController {

    var category: String?
    var startController: String?
    var selectedIngredients = [String: [String]]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
    }
    
    @IBAction func ingredientImageClicked(_ sender: UIButton) {
        
        category = sender.titleLabel?.text
        
        performSegue(withIdentifier: "Ingredient Picked", sender: nil)
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonClicked(_ sender: UIBarButtonItem) {
        guard let sc = startController else { return }
        
        if sc == "Recipe" {
            UserDefaults.standard.set(selectedIngredients, forKey: "Selected Ingredients")
        } else {
            for (cat, ingredients) in selectedIngredients {
                for i in ingredients {
                    self.ref.child("Test").child(sc).child(cat).child(i).setValue(i)
                }
            }
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? IngredientViewController, let c = category {
            destinationVC.category = c
            if let s = selectedIngredients[c] {
                destinationVC.selectedIngredients = s
            }
        }
    }
    
}
