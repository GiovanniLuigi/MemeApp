//
//  SentMemesTableViewCell.swift
//  MemeMeApp
//
//  Created by Giovanni Luidi Bruno on 03/11/20.
//  Copyright © 2020 Giovanni Luigi Bruno. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func setup(title: String, memeImage: UIImage?) {
        memeImageView.image = memeImage
        titleLabel.text = title
    }

}
