//
//  CategoryCell.swift
//  MyMenu
//
//  Created by Isaac Rand (student LM) on 3/1/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate{
    
    let ingredients: [[String]] = [
        ["Butter", "Eggs", "Milk", "Parmesan", "Cheddar", "Cream", "Sour Cream", "Cream Cheese", "Mozzarella", "American Cheese", "Yogurt", "Evaporated Milk", "Condensed Milk", "Whipped Cream", "Half and Half", "Monterey Jack Cheese", "Feta", "Cottage Cheese", "Ice Cream", "Goat Cheese", "Frosting", "Swiss Cheese", "Buttermilk", "Velveeta", "Ricotta", "Powdered Milk", "Blue Cheese", "Provolone", "Colby Cheese", "Gouda", "Pepper Jack", "Italian Cheese", "Soft Cheese", "Romano", "Brie", "Pepperjack Cheese", "Custard", "Cheese Soup", "Pizza Cheese", "Ghee", "Pecorino Cheese", "Gruyere", "Creme Fraiche", "Neufchatel", "Muenster", "Asiago", "Queso Fresco Cheese", "Hard Cheese", "Havarti Cheese", "Mascarpone", "Margarine", "Coconut Milk", "Almond Milk", "Soy Milk", "Rice Milk", "Hemp Milk", "Non Dairy Creamer"],
        ["Garlic", "Onion", "Olive", "Tomato", "Potato", "Salad Greens", "Carrot", "Basil", "Parsley", "Rosemary", "Bell Pepper", "Chili Pepper", "Corn", "Ginger", "Mushroom", "Broccoli", "Spinach", "Green Beans", "Celery", "Red Onion", "Cilantro", "Cucumber", "Pickle", "Dill", "Avocado", "Sweet Potato", "Zucchini", "Shallot", "Mixed Vegetable", "Cabbage", "Asparagus", "Cauliflower", "Mint", "Pumpkin", "Kale", "Frozen Vegetables", "Scallion", "Squash", "Sun Dried Tomato", "Horseradish", "Sweet Corn", "Beet", "Green Beans", "Peas", "Black Beans", "Chickpea", "Lentil", "Refried Beans", "Hummus", "Chili Beans", "Lima Beans", "Kidney Beans", "Pinto Beans", "Edamame", "Split Peas", "Snap Peas", "Soy Beans", "Cannellini Beans", "Navy Beans", "French Beans", "Red Beans", "Great northern Beans", "Fava Beans"],
        ["Garlic", "Onion", "Olive", "Tomato", "Potato", "Salad Greens", "Carrot", "Basil", "Parsley", "Rosemary", "Bell Pepper", "Chili Pepper", "Corn", "Ginger", "Mushroom", "Broccoli", "Spinach", "Green Beans", "Celery", "Red Onion", "Cilantro", "Cucumber", "Pickle", "Dill", "Avocado", "Sweet Potato", "Zucchini", "Shallot", "Mixed Vegetable", "Cabbage", "Asparagus", "Cauliflower", "Mint", "Pumpkin", "Kale", "Frozen Vegetables", "Scallion", "Squash", "Sun Dried Tomato", "Horseradish", "Sweet Corn", "Beet", "Green Beans", "Peas", "Black Beans", "Chickpea", "Lentil", "Refried Beans", "Hummus", "Chili Beans", "Lima Beans", "Kidney Beans", "Pinto Beans", "Edamame", "Split Peas", "Snap Peas", "Soy Beans", "Cannellini Beans", "Navy Beans", "French Beans", "Red Beans", "Great northern Beans", "Fava Beans"],
        ["Lemon", "Banana", "Apple", "Coconut", "Mango", "Lime", "Orange", "Pineapple", "Strawberries", "Raisins", "Blueberries", "Grapefruit", "Honeydew", "Grapes", "Prunes", "Nectarine", "Figs", "Peach", "Cranberries", "Raspberries", "Pear", "Cherries", "Apricot", "Blackberries", "Berries", "Dates", "Watermelon", "Kiwi", "Craisins", "Mandarins", "Cantaloupe", "Plum", "Papaya", "Pomegranate", "Apple butter", "Clementine", "Rhubarb", "Tangerine", "Sultanas", "Currant", "Plantain", "Passion Fruit", "Persimmons", "Quince", "Lychee", "Tangelos", "Lingonberry", "Kumquat", "Boysenberry", "Star Fruit", "Guava"],
        ["Rice", "Pasta", "Flour", "Bread", "Baking Powder", "Baking Soda", "Bread Crumbs", "Cornstarch", "Rolled Oats", "Noodle", "Flour Tortillas", "Pancake Mix", "Yeast", "Cracker", "Quinoa", "Brown Rice", "Cornmeal", "Self Rising Flour", "Cake Mix", "Saltines", "Popcorn", "Macaroni & Cheese Mix", "Corn Tortillas", "Ramen", "Cereal", "Biscuits", "Stuffing Mix", "Couscous", "Pie Crust", "Bisquick", "Chips", "Angel Hair", "Coconut Flake", "Bread Flour", "Croutons", "Lasagne", "Pizza Dough", "Bagel", "Puff Pastry", "Hot Dog Bun", "Barley", "Multigrain Bread", "Potato Flakes", "Pretzel", "Cornbread", "English Muffin", "Cornflour", "Crescent Roll Dough", "Cream of Wheat", "Coconut Flour", "Pita", "Risotto", "Muffin Mix", "Bicarbonate of Soda", "Ravioli", "Wheat", "Rice Flour", "Polenta", "Baguette", "Gnocchi", "Vermicelli", "Semolina", "Wheat Germ", "Buckwheat", "Croissants", "Bread Dough", "Filo Dough", "Yeast Flake", "Pierogi", "Matzo Meal", "Rye", "Tapioca Flour", "Shortcrust Pastry" ,"Potato Starch", "Breadsticks", "Ciabatta", "Spelt", "Angel Food", "Tapioca Starch", "Starch", "Whole Wheat Flour", "Gram Flour", "Sourdough Starter", "Wafer", "Bran", "Challah", "Sponge Cake", "Malt Extract", "Sorghum Flour", "Sugar", "Brown Sugar", "Honey", "Confectioners Sugar", "Maple Syrup", "Syrup", "Corn Syrup", "Molasses", "Artificial Sweetener", "Agave Nectar", "Red Pepper Flake", "Cinnamon", "Chive", "Vanilla", "Garlic Powder", "Oregano", "Paprika", "Cayenne", "Chili Powder", "Cumin", "Italian Seasoning", "Thyme", "Peppercorn", "Nutmeg", "Onion Powder", "Curry Powder", "Clove", "Bay Leaf", "Taco Seasoning", "Sage", "Ground Nutmeg", "Chinese Five Spice", "Allspice", "Turmeric", "Ground Coriander", "Coriander", "Cajun Seasoning", "Steak Seasoning", "Herbs", "Celery Salt", "Vanilla Essence", "Poultry Seasoning", "Marjoram", "Tarragon", "Cardamom", "Celery Seed", "Garam Masala", "Mustard Seed", "Chile Powder", "Italian Herbs", "Saffron", "Caraway", "Herbes de Provence", "Italian Spice", "Star Anise", "Savory", "Dill Seed", "Aniseed", "Cacao", "Tamarind"],
        ["Chicken Breast", "Ground Beef", "Bacon", "Sausage", "Cooked Chicken", "Ham", "Veal", "Beef Steak", "Hot Dog", "Pork Chops", "Chicken Thighs", "Ground Turkey", "Pork", "Turkey", "Pepperoni", "Whole Chicken", "Chicken Leg", "Ground Pork", "Chicken Wings", "Chorizo", "Polish Sausage", "Salami", "Pork Roast", "Ground Chicken", "Pork Ribs", "Venison", "Spam", "Lamb", "Pork Shoulder", "Beef Roast", "Bratwurst", "Prosciutto", "Chicken Roast", "Bologna", "Corned Beef", "Lamb Chops", "Ground Lamb", "Beef Ribs", "Duck", "Pancetta", "Beef Liver", "Leg of Lamb", "Chicken Giblets", "Beef Shank", "Pork Belly", "Cornish Hen", "Lamb Shoulder", "Lamb Shank", "Canned Tuna", "Salmon", "Fish Fillet", "Tilapia", "Haddock", "Grouper", "Cod", "Flounder", "Anchovies", "Tuna Steak", "Rockfish", "Sardines", "Smoked Salmon", "Monkfish", "Canned Salmon", "Whitefish", "Halibut", "Trout", "Mahi Mahi", "Catfish", "Sea Bass", "Mackerel", "Swordfish", "Sole", "Red Snapper", "Pollock", "Herring", "Perch", "Caviar", "Pike", "Bluefish", "Lemon Sole", "Eel", "Carp", "Cuttlefish", "Barramundi", "Shrimp", "Crab", "Prawns", "Scallop", "Clam", "Lobster", "Mussel", "Oyster", "Squid", "Calamari", "Crawfish", "Octopus", "Cockle", "Conch", "Sea Urchin"],
        ["Mayonnaise", "Ketchup", "Mustard", "Vinegar", "Soy Sauce", "Balsamic Vinegar", "Worcestershire", "Hot Sauce", "Barbecue Sauce", "Ranch Dressing", "Wine Vinegar", "Apple Cider Vinegar", "Cider Vinegar", "Italian Dressing", "Rice Vinegar", "Salad Dressing", "Tabasco", "Fish Sauce", "Teriyaki", "Steak Sauce", "Tahini", "Enchilada Sauce", "Vinaigrette Dressing", "Oyster Sauce", "Honey Mustard", "Sriracha", "Caesar Dressing", "Taco Sauce", "Mirin", "Blue Cheese Dressing", "Sweet and Sour Sauce", "Thousand Island", "Picante Sauce", "Buffalo Sauce", "French Dressing", "Tartar Sauce", "Cocktail Sauce", "Marsala", "Adobo Sauce", "Tzatziki Sauce", "Sesame Dressing", "Ponzu", "Duck Sauce", "Pickapeppa Sauce", "Yuzu Juice", "Cream Sauce"],
        ["Olive Oil", "Vegetable Oil", "Cooking Spray", "Canola Oil", "Shortening", "Sesame Oil", "Coconut Oil", "Peanut Oil", "Sunflower Oil", "Lard", "Grape Seed Oil", "Corn Oil", "Almond Oil", "Avocado Oil", "Safflower Oil", "Walnut Oil", "Hazelnut Oil", "Palm Oil", "Soybean Oil", "Mustard Oil", "Pistachio Oil", "Soya Oil", "Bouillon", "Ground Ginger", "Sesame Seed", "Cream of Tartar", "Chili Sauce", "Soya Sauce", "Apple Cider", "Hoisin Sauce", "Liquid Smoke", "Rice Wine", "Vegetable Bouillon", "Poppy Seed", "Balsamic Glaze", "Miso", "Wasabi", "Fish Stock", "Rose Water", "Pickling Salt", "Champagne Vinegar", "BBQ Rub", "Jamaican Jerk Spice", "Accent Seasoning", "Pickling Spice", "Mustard Powder", "Mango Powder", "Adobo Seasoning", "Kasuri Methi", "Caribbean Jerk Seasoning", "Brine", "Matcha Powder", "Cassia", "Tomato Sauce", "Tomato Paste", "Salsa", "Pesto", "Alfredo Sauce", "Beef Gravy", "Curry Paste", "Chicken Gravy", "Cranberry Sauce", "Turkey Gravy", "Mushroom Gravy", "Sausage Gravy", "Onion Gravy", "Cream Gravy", "Pork Gravy", "Tomato Gravy", "Giblet Gravy"],
        ["White Wine", "Beer", "Red Wine", "Vodka", "Rum", "Whiskey", "Tequila", "Sherry", "Bourbon", "Cooking Wine", "Whisky", "Liqueur", "Brandy", "Gin", "Kahlua", "Irish Cream", "Triple Sec", "Champagne", "Amaretto", "Cabernet Sauvignon", "Vermouth", "Bitters", "Maraschino", "Sake", "Grand Marnier", "Masala", "Dessert Wine", "Schnapps", "Port Wine", "Sparkling WIne", "Cognac", "Chocolate Liqueur", "Burgundy Wine", "Limoncello", "Creme de Menthe", "Bloody Mary", "Raspberry Liquor", "Curacao", "Frangelico" ,"Shaoxing Wine", "Absinthe", "Madeira Wine", "Ouzo", "Anisette", "Grappa", "Ciclon", "Drambuie", "Coffee", "Orange Juice", "Tea", "Green Tea", "Apple Juice", "Tomato Juice", "Coke", "Chocolate Milk", "Pineapple Juice", "Lemonade", "Cranberry Juice", "Espresso", "Fruit Juice", "Ginger Ale", "Club Soda", "Sprite", "Kool Aid", "Grenadine", "Margarita Mix", "Cherry Juice", "Pepsi", "Mountain Dew"],
        ["Chicken Broth", "Mushroom Soup", "Beef Broth", "Tomato Soup", "Vegetable Stock", "Chicken Soup", "Onion Soup", "Vegetable Soup", "Celery Soup", "Dashi", "Lamb Stock", "Pork Stock", "Veal Stock"],
        ["Peanut Butter", "Almond", "Walnut", "Pecan", "Peanut", "Cashew", "Flax", "Pine Nut", "Pistachio", "Almond Meal", "Hazelnut", "Macadamia", "Almond Paste", "Chestnut", "Praline", "Macaroon"],
        ["Chocolate", "Apple Sauce", "Strawberry Jam", "Graham Cracker", "Marshmallow", "Chocolate Syrup", "Potato Chips", "Nutella", "Chocolate Morsels", "Bittersweet Chocolate", "Pudding Mix", "Raspberry Jam", "Dark Chocolate", "Chocolate Chips", "Jam", "White Chocolate", "Brownie Mix", "Chocolate Pudding", "Jello", "Caramel", "Chocolate Powder", "Candy", "Corn Chips", "Cookies", "Apricot Jam", "Chocolate Bar", "Cookie Dough", "Oreo", "Doritos", "Chocolate Cookies", "Butterscotch", "Blackberry Preserves", "Blueberry Jam", "Peach Preserves", "Cherry Jam", "Fig Jam", "Plum Jam", "Cinnamon Roll", "Fudge", "Cookie Crumb", "Grape Jelly", "Chilli Jam", "Lady Fingers", "Pound Cake", "Black Pudding", "Chocolate Wafer", "Gummy Worms", "Biscotti", "Biscotti Biscuit", "Doughnut", "Amaretti Cookies", "Apple Jelly", "Red Pepper Jelly", "Orange Jelly", "Jalapeno Jelly", "Mint Jelly", "Currant Jelly", "Lemon Jelly", "Quince Jelly"
        ]
    ]
    
    var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.isHidden = true
        tableview.backgroundColor = .clear
        tableview.allowsMultipleSelection = true
        return tableview
    }()
    
    var arrowImage: UIImageView = {
        let arrow = UIImageView()
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    var categoryLabel: UILabel = {
        let category = UILabel()
        category.translatesAutoresizingMaskIntoConstraints = false
        category.font = UIFont(name: "Helvetica Neue", size: 16)
        category.textAlignment = .left
        return category
    }()
    
    var category: Int?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        tableView.dequeueReusableCell(withIdentifier: "cellID")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.addSubview(arrowImage)
        arrowImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        arrowImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        arrowImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        arrowImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addSubview(categoryLabel)
        categoryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        categoryLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! IngredientCell
        
        if let cat = category{
            cell.ingredientLabel.text = ingredients[cat][indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cat = category {
            return ingredients[cat].count
        } else {
            return 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class IngredientCell: UITableViewCell {
    
    var ingredientLabel: UILabel = {
        let ingredient = UILabel()
        ingredient.translatesAutoresizingMaskIntoConstraints = false
        ingredient.font = UIFont(name: "Helvetica Neue", size: 16)
        ingredient.textColor = .black
        ingredient.textAlignment = .left
        return ingredient
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(ingredientLabel)
        ingredientLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        ingredientLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        ingredientLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ingredientLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}