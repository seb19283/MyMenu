//
//  RecipeViewController.swift
//  MyMenu
//
//  Created by Sebastian Connelly (student LM) on 4/6/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    var recipe: RecipeEdamam?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeImageView.image = recipe?.image
        TitleLabel.adjustsFontSizeToFitWidth = true
        TitleLabel.text = recipe?.title
        
        updateDescriptionTextView()
        
    }
    
    func updateDescriptionTextView(){
        
        guard let r = recipe else {fatalError()}
        
        var text = ""
        
        text = "Yield: \(r.yield)\n"
        
        if r.tags.count > 0 {
            text += "Tags:\n"
            
            let split = r.tags.split(separator: ",")
            
            for t in split {
                var new = t
                new.removeFirst()
                text += "\(new)\n"
            }
        }
        
        text += "Ingredients:\n"
        
        for i in r.ingredients {
            text+="\(i)\n"
        }
        
        text += "Directions:\n\(r.link)"
        
        descriptionTextView.text = text
        
    }
}
