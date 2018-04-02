//
//  GenerateRecipe.swift
//  MyMenu
//
//  Created by Sebastian Connelly (student LM) on 3/20/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import Foundation

class GenerateRecipe {
    
    func getRecipesWithURL(url: String) {
        
        var recipes: [RecipeEdamam] = []
        
        let urlString = url
        
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data, let feed = (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? NSDictionary, let hits = feed["hits"] as? NSArray{
                
                for hit in hits{
                    
                    if let hit = hit as? NSDictionary, let recipe = hit.value(forKey: "recipe") as? NSDictionary, let imageURL = recipe.value(forKey: "image") as? String, let title = recipe.value(forKey: "label") as? String, let sourceURL = recipe.value(forKey: "url") as? String, let ingredients = recipe.value(forKey: "ingredientLines") as? [String], let yield = recipe.value(forKey: "yield") as? Double{
                        
                        let recipeObject = RecipeEdamam(imageURL: imageURL, title: title, sourceURL: sourceURL, ingredients: ingredients, yield: yield)
                        
                        recipes.append(recipeObject)
                        
                    }
                    
                }
                
            }
            
        }.resume()
    }
    
}
