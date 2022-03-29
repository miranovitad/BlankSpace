//
//  OwnedStickerModel.swift
//  BlankSpace
//
//  Created by Nyoman Utama Utama on 03/11/21.
//

import Foundation

class OwnedStickerModel: Identifiable {
    
    let buyDate: Date
    let idSticker: String
    
    init(_buyDate: Date, _idSticker: String) {
        self.buyDate = _buyDate
        self.idSticker = _idSticker
    }
    
}
