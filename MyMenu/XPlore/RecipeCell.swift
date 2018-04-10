//
//  RecipeCell.swift
//  MyMenu
//
//  Created by Sebastian Connelly (student LM) on 4/4/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    let recipeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 50
        return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.adjustsFontSizeToFitWidth = true
        title.font = UIFont(name: "Baskerville", size: 16)
        return title
    }()
    
    let descriptionLabel: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica Neue", size: 12)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        super.addSubview(recipeImageView)
        recipeImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        recipeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        recipeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        recipeImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        super.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: recipeImageView.rightAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        super.addSubview(descriptionLabel)
        descriptionLabel.leftAnchor.constraint(equalTo: recipeImageView.rightAnchor, constant: 8).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
