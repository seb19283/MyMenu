//
//  XPloreViewController.swift
//  MyMenu
//
//  Created by Sebastian Connelly (student LM) on 4/4/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase

class XPloreViewController: UIViewController, RecipeRequirementViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func controller(_ controller: RecipeRequirementsViewController, didFindRecipes recipes: [RecipeEdamam]) {
        self.recipes = recipes
        dismiss(animated: true) {
            UserDefaults.standard.set("", forKey: "Selected Ingredients")
            self.performSegue(withIdentifier: "recipes", sender: self)
        }
        
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    var recipes: [RecipeEdamam]?
    var recipe: RecipeEdamam?
    var xPloreRecipes = [[RecipeEdamam]]()
    var ingredients: [String] = [String]()
    var ref: DatabaseReference!
    var generate = GenerateRecipe()
    let allIngredients = AllIngredients()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        view.backgroundColor = UIColor(r: 150, g: 199, b: 149)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(XPloreCell.self, forCellWithReuseIdentifier: "cellID")
        
        ingredients = allIngredients.generateRandomIngredients(number: 5)
        generateRecipes()
        
    }
    
    func generateRecipes(){
        for i in ingredients {
            
            let url: String = "https://api.edamam.com/search?q=\(i.replacingOccurrences(of: " ", with: "+").lowercased())&app_id=ac2f75bb&app_key=f6141cadfaf7425e47266b559ff243a3&to=10"
            
            generate.getRecipesWithURL(url: url, ingredient: i, success1: { (rec, ing) in
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
                    self.xPloreRecipes.append(rec)
                    self.ingredients[self.xPloreRecipes.count-1] = ing
                    self.collectionView.reloadData()
                })
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! XPloreCell
        cell.xPloreViewController = self
        cell.recipes = xPloreRecipes[indexPath.row]
        cell.nameLabel.text = ingredients[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return xPloreRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 180)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GenerateViewController {
            destination.recipes = recipes
        } else if let vc = segue.destination as? RecipeRequirementsViewController {
            UserDefaults.standard.set("", forKey: "Selected Ingredients")
            vc.delegate = self
        } else if let vc = segue.destination as? RecipeViewController {
            vc.recipe = recipe
        }
    }
    
}
