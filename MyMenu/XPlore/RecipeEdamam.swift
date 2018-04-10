//
//  RecipeEdamam.swift
//  MyMenu
//
//  Created by Isaac Rand (student LM) on 3/19/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit

class RecipeEdamam{
    
    var image: UIImage?
    var title: String
    var link: URL?
    var favorited: Bool
    var ingredients: [String]
    var yield: Double
    var tags: String
    //         let recipeObject = Recipe(imageURL: imageURL, title: title, sourceURL: sourceURL, ingredients: ingredients, yield: yield)
    init(imageURL: String, title: String, sourceURL: String, ingredients: [String], yield: Double, tags: String){
        
        self.title = title
        self.favorited = false
        self.ingredients = ingredients
        self.yield = yield
        self.tags = tags
        
        self.image = UIImage()
        
        if let url = URL(string: sourceURL){
            self.link = url
        }
        
        URLSession.shared.dataTask(with: URL(string: imageURL)!) { (data, response, error) in
            if let imageData = data {
                self.image = UIImage(data: imageData)!
            }
        }.resume()
        
        
    }
    
}

