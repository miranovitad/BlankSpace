//
//  StoryStickerManager.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//

import Foundation

struct StoryStickerManager
{
    private let _storyStickerDataRepository = StoryStickerDataRepository()
    
    func createStorySticker(record: StoryStickerModel)
    {
        _storyStickerDataRepository.create(record: record)
    }

    func getAll() -> [StoryStickerModel]?
    {
        return _storyStickerDataRepository.getAll()
    }
}
