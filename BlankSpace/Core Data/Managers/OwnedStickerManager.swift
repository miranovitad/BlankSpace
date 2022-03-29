//
//  StoryStickerManager.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//

import Foundation

struct OwnedStickerManager
{
    private let _ownedStickerDataRepository = OwnedStickerDataRepository()
    
    func createOwnedSticker(record: OwnedStickerModel) -> Bool
    {
        _ownedStickerDataRepository.create(record: record)
        return true
    }

    func getAll() -> [OwnedStickerModel]?
    {
        return _ownedStickerDataRepository.getAll()
    }
}

