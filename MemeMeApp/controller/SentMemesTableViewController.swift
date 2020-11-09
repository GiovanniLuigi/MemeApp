//
//  SentMemesTableViewController.swift
//  MemeMeApp
//
//  Created by Giovanni Luidi Bruno on 03/11/20.
//  Copyright © 2020 Giovanni Luigi Bruno. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var selectedRow: Int?
    
    var memes: [Meme] {
        return Data.shared.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Data.shared.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SentMemesTableViewCell.reuseIdentifier) as? SentMemesTableViewCell {
            let meme = memes[indexPath.row]
            cell.setup(title: meme.topText, memeImage: meme.memedImage)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            vc.selectedImage = memes[indexPath.row].memedImage
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func dataUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

}
