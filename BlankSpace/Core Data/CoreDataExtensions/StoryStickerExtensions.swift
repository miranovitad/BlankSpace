//
//  StoryStickerExtensions.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//

import Foundation

extension StorySticker
{
    func convertToSticker() -> StoryStickerModel
    {
        return StoryStickerModel(_idStorySticker: self.idStorySticker!, _x: self.x, _y: self.y)
    }
}
