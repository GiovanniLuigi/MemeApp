//
//  SentMemesCollectionViewController.swift
//  MemeMeApp
//
//  Created by Giovanni Luidi Bruno on 06/11/20.
//  Copyright © 2020 Giovanni Luigi Bruno. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, DataDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes: [Meme] {
        return Data.shared.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Data.shared.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SentMemesCollectionViewCell.reuseIdentifier, for: indexPath) as? SentMemesCollectionViewCell{
            
            cell.setup(memeImage: memes[indexPath.row].memedImage)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 12 * 3) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            vc.selectedImage = memes[indexPath.row].memedImage
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func dataUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}
