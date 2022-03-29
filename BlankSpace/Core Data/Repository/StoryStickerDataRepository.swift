//
//  StoryStickerDataRepository.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//

import Foundation
import CoreData

protocol StoryStickerRepository: BaseRepositoryIdString {

}

struct StoryStickerDataRepository: StoryStickerRepository {
    
    func create(record: StoryStickerModel) {

        let cdStorySticker = StorySticker(context: PersistentStorage.shared.context)
        cdStorySticker.idStorySticker = record.idStorySticker
        cdStorySticker.x = record.x
        cdStorySticker.y = record.y

        PersistentStorage.shared.saveContext()
    }

    func getAll() -> [StoryStickerModel]? {
        
        let records = PersistentStorage.shared.fetchManagedObject(managedObject: StorySticker.self)
        guard records != nil && records?.count != 0 else {return nil}

        var results: [StoryStickerModel] = []
        records!.forEach({ (cdSticker) in
            results.append(cdSticker.convertToSticker())
        })
        
        return results
    }

    func get(byIdentifier idStorySticker: String) -> StoryStickerModel? {

        let storySticker = getCdStorySticker(byId: idStorySticker)
        guard storySticker != nil else {return nil}
        return (storySticker?.convertToSticker())!
    }

    func update(record: StoryStickerModel) -> Bool {
        
        let storySticker = getCdStorySticker(byId: record.idStorySticker)
        guard storySticker != nil else {return false}

        storySticker?.idStorySticker = record.idStorySticker
        storySticker?.x = record.x
        storySticker?.y = record.y

        PersistentStorage.shared.saveContext()
        
        return true
    }

    func delete(byIdentifier idStorySticker: String) -> Bool {

        let storySticker = getCdStorySticker(byId: idStorySticker)
        guard storySticker != nil else {return false}

        PersistentStorage.shared.context.delete(storySticker!)
        PersistentStorage.shared.saveContext()

        return true
    }

    private func getCdStorySticker(byId idStorySticker: String) -> StorySticker?
    {
        let fetchRequest = NSFetchRequest<StorySticker>(entityName: "StorySticker")
        let fetchById = NSPredicate(format: "id==%@", idStorySticker as CVarArg)
        fetchRequest.predicate = fetchById

        let result = try! PersistentStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}

        return result.first
    }


    typealias T = StoryStickerModel

}
