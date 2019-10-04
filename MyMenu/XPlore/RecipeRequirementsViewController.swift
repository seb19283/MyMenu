// RecipeRequirementsViewController.swift
//  MyMenu
//
//  Created by Sebastian Connelly (student LM) on 4/4/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.

import UIKit

protocol RecipeRequirementViewControllerDelegate: class {
    func controller(_ controller: RecipeRequirementsViewController, didFindRecipes recipes: [RecipeEdamam])
}

class RecipeRequirementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    weak var delegate: RecipeRequirementViewControllerDelegate?

    @IBOutlet var ingredientTableView: UITableView!
    @IBOutlet var tagsTableView: UITableView!
    @IBOutlet var fastButton: UIButton!
    @IBOutlet var mediumButton: UIButton!
    @IBOutlet var slowButton: UIButton!
    
    var selectedTags = [String]()
    var tags = ["Balanced", "High-protein", "Low-fat", "Low-carb", "Vegan", "Vegetarian", "Sugar-conscious", "Peanut-free", "Tree-nut-free", "Alchohol-free"]
    var selectedIngredients = [String]()
    var speed: String = "time=0-30"
    var recipeGenerator = GenerateRecipe()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        ingredientTableView.allowsSelection = false
        ingredientTableView.tableFooterView = UIView()
        
        tagsTableView.delegate = self
        tagsTableView.dataSource = self
        
        ingredientTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tagsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnScreen))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let ingredientsAndCategories = UserDefaults.standard.value(forKey: "Selected Ingredients") as? [String: [String]] else { return }
        
        selectedIngredients = [String]()
        
        for (_,ingredientList) in ingredientsAndCategories{
            for i in ingredientList {
                selectedIngredients.append(i)
            }
        }
        
        ingredientTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ingredientTableView {
            return selectedIngredients.count
        } else {
            return tags.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! UITableViewCell
        
        if tableView == ingredientTableView {
            cell.textLabel?.text = selectedIngredients[indexPath.row]
            cell.accessoryType = .none
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
        
        if tableView != ingredientTableView {
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
        self.dismiss(animated: true) {
            UserDefaults.standard.set("", forKey: "Selected Ingredients")
        }
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
        
        let spinnerView = UIView.init(frame: self.view.bounds)
        let screenSize: CGRect = UIScreen.main.bounds
        spinnerView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let myView = SpinnerView(frame: CGRect(x: screenSize.width/2-50, y: screenSize.height/2-50, width: 100, height: 100))
        spinnerView.addSubview(myView)
        self.view.addSubview(spinnerView)
        
        recipeGenerator.getRecipesWithURL(url: url, success1: { (recipes, _) in
            if recipes.count == 0 {
                self.alertMessage("No Recipes Available")
                spinnerView.removeFromSuperview()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? UINavigationController, let targetVC = destinationVC.topViewController as? AddIngredientsViewController {
            targetVC.startController = "Recipe"
            if let s = UserDefaults.standard.value(forKey: "Selected Ingredients") as? [String: [String]] {
                targetVC.selectedIngredients = s
            }
        }
    }
    
}
