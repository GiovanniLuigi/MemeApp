//
//  DetailViewController.swift
//  MemeMeApp
//
//  Created by Giovanni Luidi Bruno on 09/11/20.
//  Copyright © 2020 Giovanni Luigi Bruno. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var memeImageView: UIImageView!
    var selectedImage: UIImage?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeImageView.image = selectedImage
    }
}
