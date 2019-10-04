//
//  XPloreCell.swift
//  MyMenu
//
//  Created by Sebastian Connelly (student LM) on 5/1/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit

class XPloreCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var recipes: [RecipeEdamam]?
    var xPloreViewController: XPloreViewController?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let recipesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews(){
        
        backgroundColor = .clear
        
        addSubview(nameLabel)
        addSubview(recipesCollectionView)
        addSubview(dividerLineView)
        
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        
        recipesCollectionView.register(XPloreRecipeCell.self, forCellWithReuseIdentifier: "recipCellID")
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLineView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": recipesCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": recipesCollectionView, "v1": dividerLineView, "nameLabel": nameLabel]))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let r = recipes{
            return r.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let r = recipes else {return UICollectionViewCell()}
        
        let cell = recipesCollectionView.dequeueReusableCell(withReuseIdentifier: "recipCellID", for: indexPath) as! XPloreRecipeCell
        
        cell.imageView.image = r[indexPath.row].image
        cell.titleLabel.text = r[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let controller = xPloreViewController {
            controller.recipe = recipes![indexPath.row]
            controller.performSegue(withIdentifier: "collectionViewRecipe", sender: nil)
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    
}

class XPloreRecipeCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been initialized")
    }
    
    var recipe: RecipeEdamam?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 16
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        return label
    }()
    
    func setupViews(){
        
        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        
        addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 0, y: frame.width+2, width: frame.width, height: 40)
        
    }
    
}
