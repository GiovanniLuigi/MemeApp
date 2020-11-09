//
//  SentMemesCollectionViewCell.swift
//  MemeMeApp
//
//  Created by Giovanni Luidi Bruno on 06/11/20.
//  Copyright © 2020 Giovanni Luigi Bruno. All rights reserved.
//

import UIKit

class SentMemesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
    
    
    func setup(memeImage: UIImage?) {
        memeImageView.image = memeImage
    }
    
}
