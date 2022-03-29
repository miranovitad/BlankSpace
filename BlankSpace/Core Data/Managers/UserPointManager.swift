//
//  StoryStickerManager.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//

import Foundation

struct UserPointManager
{
    private let _userPointDataRepository = UserPointDataRepository()
    
    func createUserPoint(record: UserPointModel) -> Bool
    {
        _userPointDataRepository.create(record: record)
        return true
    }

    func getAll() -> [UserPointModel]?
    {
        return _userPointDataRepository.getAll()
    }
}

