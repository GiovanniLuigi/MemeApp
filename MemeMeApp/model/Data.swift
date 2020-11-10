//
//  Data.swift
//  MemeMeApp
//
//  Created by Giovanni Luidi Bruno on 03/11/20.
//  Copyright © 2020 Giovanni Luigi Bruno. All rights reserved.
//

import Foundation

protocol DataDelegate {
    func dataUpdated()
}

class Data {
    
    static let shared = Data()
    
    var memes = [Meme]()
    var delegate: DataDelegate?
    
    private init() {}
    
    func add(meme: Meme) {
        memes.append(meme)
        delegate?.dataUpdated()
    }
    
}
