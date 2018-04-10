//
//  RecipeRequirementsViewController.swift
//  MyMenu
//
//  Created by Sebastian Connelly (student LM) on 4/4/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit

protocol RecipeRequirementViewControllerDelegate: class {
    func controller(_ controller: RecipeRequirementsViewController, didFindRecipes recipes: [RecipeEdamam])
}

class RecipeRequirementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    weak var delegate: RecipeRequirementViewControllerDelegate?

    @IBOutlet var ingredientTableView: UITableView!
    @IBOutlet var tagsTableView: UITableView!
    @IBOutlet var ingredientSearchBar: UISearchBar!
    @IBOutlet var fastButton: UIButton!
    @IBOutlet var mediumButton: UIButton!
    @IBOutlet var slowButton: UIButton!
    
    var selectedIngredients = [String]()
    var selectedTags = [String]()
    var tags = ["Balanced", "High-protein", "Low-fat", "Low-carb", "Vegan", "Vegetarian", "Sugar-conscious", "Peanut-free", "Tree-nut-free", "Alchohol-free"]
    var isSearching: Bool = false
    var filteredData = [String]()
    var speed: String = "time=0-30"
    var recipeGenerator = GenerateRecipe()
    
    var ingredients: [String] = ["Butter", "Eggs", "Milk", "Parmesan", "Cheddar", "Cream", "Sour Cream", "Cream Cheese", "Mozzarella", "American Cheese", "Yogurt", "Evaporated Milk", "Condensed Milk", "Whipped Cream", "Half and Half", "Monterey Jack Cheese", "Feta", "Cottage Cheese", "Ice Cream", "Goat Cheese", "Frosting", "Swiss Cheese", "Buttermilk", "Velveeta", "Ricotta", "Powdered Milk", "Blue Cheese", "Provolone", "Colby Cheese", "Gouda", "Pepper Jack", "Italian Cheese", "Soft Cheese", "Romano", "Brie", "Pepperjack Cheese", "Custard", "Cheese Soup", "Pizza Cheese", "Ghee", "Pecorino Cheese", "Gruyere", "Creme Fraiche", "Neufchatel", "Muenster", "Asiago", "Queso Fresco Cheese", "Hard Cheese", "Havarti Cheese", "Mascarpone", "Margarine", "Coconut Milk", "Almond Milk", "Soy Milk", "Rice Milk", "Hemp Milk", "Non Dairy Creamer", "Vegetables & Legumes", "Garlic", "Onion", "Olive", "Tomato", "Potato", "Salad Greens", "Carrot", "Basil", "Parsley", "Rosemary", "Bell Pepper", "Chili Pepper", "Corn", "Ginger", "Mushroom", "Broccoli", "Spinach", "Green Beans", "Celery", "Red Onion", "Cilantro", "Cucumber", "Pickle", "Dill", "Avocado", "Sweet Potato", "Zucchini", "Shallot", "Mixed Vegetable", "Cabbage", "Asparagus", "Cauliflower", "Mint", "Pumpkin", "Kale", "Frozen Vegetables", "Scallion", "Squash", "Sun Dried Tomato", "Horseradish", "Sweet Corn", "Beet", "Green Beans", "Peas", "Black Beans", "Chickpea", "Lentil", "Refried Beans", "Hummus", "Chili Beans", "Lima Beans", "Kidney Beans", "Pinto Beans", "Edamame", "Split Peas", "Snap Peas", "Soy Beans", "Cannellini Beans", "Navy Beans", "French Beans", "Red Beans", "Great northern Beans", "Fava Beans", "Lemon", "Banana", "Apple", "Coconut", "Mangoe", "Lime", "Orange", "Pineapple", "Strawberries", "Raisin", "Blueberries", "Grapefruit", "Honeydew", "Grapes", "Prunes", "Nectarine", "Fig", "Peaches", "Cranberries", "Raspberries", "Pear", "Cherries", "Apricot", "Blackberries", "Berries", "Date", "Watermelon", "Kiwi", "Craisin", "Mandarin", "Cantaloupe", "Plum", "Papaya", "Pomegranate", "Apple butter", "Clementine", "Rhubarb", "Tangerine", "Sultanas", "Currants", "Plantain", "Passion Fruit", "Persimmon", "Quince", "Lychee", "Tangelo", "Lingonberries", "Kumquat", "Boysenberries", "Star Fruit", "Guava", "Pasta", "Baking Powder", "Baking Soda", "Bread Crumbs", "Cornstarch", "Rolled Oats", "Cake Mix", "Noodle", "Flour Tortillas", "Pancake Mix", "Yeast", "Cracker", "Quinoa", "Brown Rice", "Cornmeal", "Self Rising Flour", "Cake Mix", "Saltines", "Popcorn", "Macaroni & Cheese Mix", "Corn Tortillas", "Ramen", "Cereal", "Biscuits", "Stuffing Mix", "Couscous", "Pie Crust", "Bisquick", "Chips", "Angel Hair", "Coconut Flake", "Bread Flour", "Croutons", "Lasagne", "Pizza Dough", "Bagel", "Puff Pastry", "Hot Dog Bun", "Barley", "Multigrain Bread", "Potato Flakes", "Pretzel", "Cornbread", "English Muffin", "Cornflour", "Crescent Roll Dough", "Cream of Wheat", "Coconut Flour", "Pita", "Risotto", "Muffin Mix", "Bicarbonate of Soda", "Ravioli", "Wheat", "Rice Flour", "Polenta", "Baguette", "Gnocchi", "Vermicelli", "Semolina", "Wheat Germ", "Buckwheat", "Croissants", "Bread Dough", "Filo Dough", "Yeast Flake", "Pierogi", "Matzo Meal", "Rye", "Tapioca Flour", "Shortcrust Pastry" ,"Potato Starch", "Breadsticks", "Ciabatta", "Spelt", "Angel Food", "Tapioca Starch", "Starch", "Whole Wheat Flour", "Gram Flour", "Sourdough Starter", "Wafer", "Bran", "Challah", "Sponge Cake", "Malt Extract", "Sorghum Flour", "Sugar", "Brown Sugar", "Honey", "Confectioners Sugar", "Maple Syrup", "Syrup", "Corn Syrup", "Molasses", "Artificial Sweetener", "Agave Nectar", "Red Pepper Flake", "Cinnamon", "Chive", "Garlic Powder", "Oregano", "Paprika", "Cayenne", "Chili Powder", "Cumin", "Italian Seasoning", "Thyme", "Peppercorn", "Nutmeg", "Onion Powder", "Curry Powder", "Clove", "Bay Leaf", "Taco Seasoning", "Sage", "Ground Nutmeg", "Chinese Five Spice", "Allspice", "Turmeric", "Ground Coriander", "Coriander", "Cajun Seasoning", "Steak Seasoning", "Herbs", "Celery Salt", "Vanilla Essence", "Poultry Seasoning", "Marjoram", "Tarragon", "Cardamom", "Celery Seed", "Garam Masala", "Mustard Seed", "Chile Powder", "Italian Herbs", "Saffron", "Caraway", "Herbes de Provence", "Italian Spice", "Star Anise", "Savory", "Dill Seed", "Aniseed", "Cacao", "Tamarind", "Flour", "Bread", "Rice", "Salt", "Pepper", "Vanilla Extract", "Vanilla Bean", "Vanilla", "Chicken Breast", "Ground Beef", "Bacon", "Sausage", "Cooked Chicken", "Ham", "Veal", "Beef Steak", "Hot Dog", "Pork Chops", "Chicken Thighs", "Ground Turkey", "Pork", "Turkey", "Pepperoni", "Whole Chicken", "Chicken Leg", "Ground Pork", "Chicken Wings", "Chorizo", "Polish Sausage", "Salami", "Pork Roast", "Ground Chicken", "Pork Ribs", "Venison", "Spam", "Pork Shoulder", "Beef Roast", "Bratwurst", "Prosciutto", "Chicken Roast", "Bologna", "Corned Beef", "Lamb Chops", "Ground Lamb", "Beef Ribs", "Pancetta", "Beef Liver", "Leg of Lamb", "Chicken Giblets", "Beef Shank", "Pork Belly", "Cornish Hen", "Lamb Shoulder", "Lamb Shank", "Canned Tuna", "Fish Fillet", "Tilapia", "Haddock", "Grouper", "Cod", "Flounder", "Anchovies", "Tuna Steak", "Rockfish", "Sardines", "Smoked Salmon", "Monkfish", "Canned Salmon", "Whitefish", "Halibut", "Trout", "Mahi Mahi", "Catfish", "Sea Bass", "Mackerel", "Swordfish", "Sole", "Red Snapper", "Pollock", "Herring", "Perch", "Caviar", "Pike", "Bluefish", "Lemon Sole", "Eel", "Carp", "Cuttlefish", "Barramundi", "Shrimp", "Crab", "Prawns", "Scallop", "Clam", "Lobster", "Mussel", "Oyster", "Squid", "Calamari", "Crawfish", "Octopus", "Cockle", "Conch", "Sea Urchin", "Pork", "Lamb", "Duck", "Salmon", "Tuna", "Mayonnaise", "Ketchup", "Mustard", "Soy Sauce", "Balsamic Vinegar", "Worcestershire", "Hot Sauce", "Barbecue Sauce", "Ranch Dressing", "Wine Vinegar", "Apple Cider Vinegar", "Cider Vinegar", "Italian Dressing", "Rice Vinegar", "Salad Dressing", "Tabasco", "Fish Sauce", "Teriyaki", "Steak Sauce", "Tahini", "Enchilada Sauce", "Vinaigrette Dressing", "Oyster Sauce", "Honey Mustard", "Sriracha", "Caesar Dressing", "Taco Sauce", "Mirin", "Blue Cheese Dressing", "Sweet and Sour Sauce", "Thousand Island", "Picante Sauce", "Buffalo Sauce", "French Dressing", "Tartar Sauce", "Cocktail Sauce", "Marsala", "Adobo Sauce", "Tzatziki Sauce", "Sesame Dressing", "Ponzu", "Duck Sauce", "Pickapeppa Sauce", "Yuzu Juice", "Cream Sauce", "Vinegar", "Olive Oil", "Vegetable Oil", "Cooking Spray", "Canola Oil", "Shortening", "Sesame Oil", "Coconut Oil", "Peanut Oil", "Sunflower Oil", "Lard", "Grape Seed Oil", "Corn Oil", "Almond Oil", "Avocado Oil", "Safflower Oil", "Walnut Oil", "Hazelnut Oil", "Palm Oil", "Soybean Oil", "Mustard Oil", "Pistachio Oil", "Soya Oil", "Bouillon", "Ground Ginger", "Sesame Seed", "Cream of Tartar", "Chili Sauce", "Soya Sauce", "Apple Cider", "Hoisin Sauce", "Liquid Smoke", "Rice Wine", "Vegetable Bouillon", "Poppy Seed", "Balsamic Glaze", "Miso", "Wasabi", "Fish Stock", "Rose Water", "Pickling Salt", "Champagne Vinegar", "BBQ Rub", "Jamaican Jerk Spice", "Accent Seasoning", "Pickling Spice", "Mustard Powder", "Mango Powder", "Adobo Seasoning", "Kasuri Methi", "Caribbean Jerk Seasoning", "Brine", "Matcha Powder", "Cassia", "Tomato Sauce", "Tomato Paste", "Salsa", "Pesto", "Alfredo Sauce", "Beef Gravy", "Curry Paste", "Chicken Gravy", "Cranberry Sauce", "Turkey Gravy", "Mushroom Gravy", "Sausage Gravy", "Onion Gravy", "Cream Gravy", "Pork Gravy", "Tomato Gravy", "Giblet Gravy", "White Wine", "Red Wine", "Vodka", "Rum", "Whiskey", "Tequila", "Sherry", "Bourbon", "Cooking Wine", "Whisky", "Liqueur", "Brandy", "Gin", "Kahlua", "Irish Cream", "Triple Sec", "Champagne", "Amaretto", "Cabernet Sauvignon", "Vermouth", "Bitters", "Maraschino", "Sake", "Grand Marnier", "Masala", "Dessert Wine", "Schnapps", "Port Wine", "Sparkling WIne", "Cognac", "Chocolate Liqueur", "Burgundy Wine", "Limoncello", "Creme de Menthe", "Bloody Mary", "Raspberry Liquor", "Curacao", "Frangelico" ,"Shaoxing Wine", "Absinthe", "Madeira Wine", "Ouzo", "Anisette", "Grappa", "Ciclon", "Drambuie", "Coffee", "Orange Juice", "Tea ", "Green Tea", "Apple Juice", "Tomato Juice", "Coke", "Chocolate Milk", "Pineapple Juice", "Lemonade", "Cranberry Juice", "Espresso", "Fruit Juice", "Ginger Ale", "Club Soda", "Sprite", "Kool Aid", "Grenadine", "Margarita Mix", "Cherry Juice", "Pepsi", "Mountain Dew", "Beer", "Chicken Broth", "Mushroom Soup", "Beef Broth", "Tomato Soup", "Vegetable Stock", "Chicken Soup", "Onion Soup", "Vegetable Soup", "Celery Soup", "Dashi", "Lamb Stock", "Pork Stock", "Veal Stock", "Peanut Butter", "Almond", "Walnut", "Pecan", "Peanut", "Cashew", "Flax", "Pine Nut", "Pistachio", "Almond Meal", "Hazelnut", "Macadamia", "Almond Paste", "Chestnut", "Praline", "Macaroon", "Apple Sauce", "Strawberry Jam", "Graham Cracker", "Chocolate Syrup", "Potato Chips", "Nutella", "Chocolate Morsels", "Bittersweet Chocolate", "Pudding Mix", "Raspberry Jam", "Dark Chocolate", "Chocolate Chips", "White Chocolate", "Brownie Mix", "Chocolate Pudding", "Chocolate Powder", "Candy", "Corn Chips", "Cookies", "Apricot Jam", "Chocolate Bar", "Cookie Dough", "Oreo", "Doritos", "Chocolate Cookies", "Butterscotch", "Blackberry Preserves", "Blueberry Jam", "Peach Preserves", "Cherry Jam", "Fig Jam", "Plum Jam", "Cinnamon Roll", "Fudge", "Cookie Crumb", "Grape Jelly", "Chilli Jam", "Lady Fingers", "Pound Cake", "Black Pudding", "Chocolate Wafer", "Gummy Worms", "Biscotti", "Biscotti Biscuit", "Doughnut", "Amaretti Cookies", "Apple Jelly", "Red Pepper Jelly", "Orange Jelly", "Jalapeno Jelly", "Mint Jelly", "Currant Jelly", "Lemon Jelly", "Quince Jelly", "Strawberry Jelly", "Chocolate", "Marshmallow", "Jam", "Jello", "Caramel"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        ingredientTableView.allowsSelection = false
        
        tagsTableView.delegate = self
        tagsTableView.dataSource = self
        
        ingredientTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tagsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
        ingredientSearchBar.delegate = self
        ingredientSearchBar.returnKeyType = .done
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnScreen))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func tappedOnScreen() {
        view.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            self.view.endEditing(true)
            ingredientTableView.reloadData()
        } else {
            isSearching = true
            filteredData = ingredients.filter({ (ingredient) -> Bool in
                guard let text = searchBar.text else {return false}
                return ingredient.contains(text)
            })
            ingredientTableView.reloadData()
        }
        
        if isSearching {
            ingredientTableView.allowsSelection = true
        } else {
            ingredientTableView.allowsSelection = false
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ingredientTableView {
            if isSearching {
                return filteredData.count
            } else {
                return selectedIngredients.count
            }
        } else {
            return tags.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! UITableViewCell
        
        if tableView == ingredientTableView {
            if isSearching {
                cell.textLabel?.text = filteredData[indexPath.row]
                if let text = cell.textLabel?.text, selectedIngredients.contains(text) {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
            } else {
                cell.textLabel?.text = selectedIngredients[indexPath.row]
                cell.accessoryType = .none
            }
        } else {
            cell.textLabel?.text = tags[indexPath.row]
            
            if let text = cell.textLabel?.text, selectedTags.contains(text) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == ingredientTableView {
            if isSearching{
                let cell = tableView.cellForRow(at: indexPath)
                
                if cell?.accessoryType == .checkmark {
                    cell?.accessoryType = .none
                    selectedIngredients.remove(at: selectedIngredients.index(of: filteredData[indexPath.row])!)
                } else {
                    cell?.accessoryType = .checkmark
                    selectedIngredients.append(filteredData[indexPath.row])
                }
                
            }
        } else {
            let cell = tableView.cellForRow(at: indexPath)
            if cell?.accessoryType == .checkmark {
                cell?.accessoryType = .none
                selectedTags.remove(at: selectedTags.index(of: tags[indexPath.row])!)
            } else {
                cell?.accessoryType = .checkmark
                selectedTags.append(tags[indexPath.row])
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func fastButtonClicked(_ sender: UIButton) {
        speed = "time=0-30"
        
        fastButton.isSelected = true
        mediumButton.isSelected = false
        slowButton.isSelected = false
    }
    
    @IBAction func mediumButtonClicked(_ sender: UIButton) {
        speed = "time=30-90"
        
        fastButton.isSelected = false
        mediumButton.isSelected = true
        slowButton.isSelected = false
    }
    
    @IBAction func slowButtonClicked(_ sender: UIButton) {
        speed = "time=90%2B"
        
        fastButton.isSelected = false
        mediumButton.isSelected = false
        slowButton.isSelected = true
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func generateButtonClicked(_ sender: UIBarButtonItem) {
        
        var url = "https://api.edamam.com/search?q="
        
        for i in selectedIngredients {
            let newString = i.replacingOccurrences(of: " ", with: "+")
            
            url+="\(newString.lowercased()),"
        }
        
        url.removeLast()
        url += "&app_id=ac2f75bb&app_key=f6141cadfaf7425e47266b559ff243a3&to=30"
        
        for d in selectedTags {
            if d == "Balanced" || d == "High-protein" || d == "Low-fat" || d == "Low-carb" {
                url+="&diet=\(d.lowercased())"
            }
        }
        
        for h in selectedTags {
            if h != "Balanced" && h != "High-protein" && h != "Low-fat" && h != "Low-carb" {
                url+="&health=\(h.lowercased())"
            }
        }
        
        url+="&\(speed)"
        
        recipeGenerator.getRecipesWithURL(url: url, success: { (recipes) in
            
            if recipes.count == 0 {
                self.alertMessage("No Recipes Available")
            } else {
                self.delegate?.controller(self, didFindRecipes: recipes)
            }
            
        })
        
    }
    
    
    func alertMessage(_ message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(OK)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
