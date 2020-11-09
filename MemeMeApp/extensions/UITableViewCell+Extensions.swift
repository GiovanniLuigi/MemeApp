//
//  UITableViewCell+Extensions.swift
//  MemeMeApp
//
//  Created by Giovanni Luidi Bruno on 03/11/20.
//  Copyright © 2020 Giovanni Luigi Bruno. All rights reserved.
//

import UIKit


extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
