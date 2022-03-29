//
//  StoryManager.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//

import Foundation

struct StoryManager
{
    private let _storyDataRepository = StoryDataRepository()
    
    func createStory(record: StoryModel) -> Bool
    {
        guard record.stickers != nil && record.stickers!.count <= 2 else {return false}
        _storyDataRepository.create(record: record)
        
        return true
    }

    func getAll() -> [StoryModel]?
    {
        return _storyDataRepository.getAll()
    }
    
    func delete(record: StoryModel) -> Bool {
//        guard record.idStory != nil else { return false }
        let deleted = _storyDataRepository.delete(byIdentifier: record.idStory)
//        print(record.idStory)
//        print(_storyDataRepository.get(byIdentifier: record.idStory))
        return deleted
//        return true
    }
    
    func update(record: StoryModel) -> Bool {
        let updated = _storyDataRepository.update(record: record)
        print("massa gamasuk")
        return updated
    }
}
