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
    //         let recipeObject = Recipe(imageURL: imageURL, title: title, sourceURL: sourceURL, ingredients: ingredients, yield: yield)
    init(imageURL: String, title: String, sourceURL: String, ingredients: [String], yield: Double){
        
        self.title = title
        self.favorited = false
        self.ingredients = ingredients
        self.yield = yield
        
        self.image = UIImage()
        
        if let url = URL(string: sourceURL){
            self.link = url
        }
        
        let request = URLRequest(url: URL(string: imageURL)!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let imageData = data {
                self.image = UIImage(data: imageData)
            }
        }.resume()
        
        
    }
    
}

