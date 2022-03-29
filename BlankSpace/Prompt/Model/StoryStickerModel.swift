//
//  StoryStickerModel.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//

import Foundation

class StoryStickerModel {
    
    let idStorySticker: String
    let x: Int32
    let y: Int32
    let idStory: UUID?
    
    init(_idStorySticker: String, _x: Int32, _y: Int32, _idStory: UUID? = nil) {
        self.idStorySticker = _idStorySticker
        self.x = _x
        self.y = _y
        self.idStory = _idStory
    }
    
}
