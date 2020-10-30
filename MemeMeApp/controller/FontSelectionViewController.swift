//
//  FontSelectionViewController.swift
//  MemeMeApp
//
//  Created by Giovanni Luidi Bruno on 29/10/20.
//  Copyright © 2020 Giovanni Luigi Bruno. All rights reserved.
//

import UIKit


protocol FontSelectionDelegate {
    func didSelectFont(font: String)
}

class FontSelectionViewController: UIViewController {
    
    var selectedFont: String?
    var delegate: FontSelectionDelegate?

    @IBAction func didSelectFont(_ sender: UIButton) {
        self.selectedFont = sender.titleLabel?.font.familyName
        if let delegate = self.delegate, let selectedFont = self.selectedFont {
            delegate.didSelectFont(font: selectedFont)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
