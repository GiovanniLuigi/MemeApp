//
//  UICollectionViewCell+Extensions.swift
//  MemeMeApp
//
//  Created by Giovanni Luidi Bruno on 09/11/20.
//  Copyright © 2020 Giovanni Luigi Bruno. All rights reserved.
//

import UIKit


extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
