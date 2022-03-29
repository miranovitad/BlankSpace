//
//  OwnedStickerExtensions.swift
//  BlankSpace
//
//  Created by Mira on 03/11/21.
//

import Foundation

extension OwnedSticker
{
    func convertToOwnedSticker() -> OwnedStickerModel
    {
        return OwnedStickerModel(_buyDate: self.buyDate!, _idSticker: self.idSticker!)
    }
}
