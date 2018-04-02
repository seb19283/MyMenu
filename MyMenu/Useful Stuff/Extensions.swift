//
//  Extensions.swift
//  MyMenu
//
//  Created by Sebastian Connelly (student LM) on 3/16/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: Int, g: Int, b: Int){
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
}
