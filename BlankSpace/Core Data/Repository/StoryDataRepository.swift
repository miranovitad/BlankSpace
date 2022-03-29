//
//  StoryDataRepository.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//

import Foundation
import CoreData

protocol StoryRepository : BaseRepository {

}

struct StoryDataRepository : StoryRepository {

    func create(record: StoryModel) {

        let cdStory = Story(context: PersistentStorage.shared.context)
        cdStory.idStory = record.idStory
        cdStory.date = record.date
        cdStory.mood = record.mood.rawValue
        cdStory.aspect = record.aspect.rawValue
        cdStory.title = record.title
        cdStory.content = record.content

        if(record.stickers != nil && record.stickers?.count != 0)
        {
            var stickerSet = Set<StorySticker>()
            record.stickers?.forEach({ (sticker) in

                let cdSticker = StorySticker(context: PersistentStorage.shared.context)
                cdSticker.idStorySticker = sticker.idStorySticker
                cdSticker.x = sticker.x
                cdSticker.y = sticker.y

                stickerSet.insert(cdSticker)
            })
            
            cdStory.storySticker = stickerSet
            
        }

        PersistentStorage.shared.saveContext()

    }

    func getAll() -> [StoryModel]? {

        let records = PersistentStorage.shared.fetchManagedObject(managedObject: Story.self)
        guard records != nil && records?.count != 0 else {return nil}

        var results: [StoryModel] = []
        
        records!.forEach({ (cdStory) in
            results.append(cdStory.convertToStory())
        })

        return results
    }

    func get(byIdentifier idStory: UUID) -> StoryModel? {

        let story = getCdStory(byId: idStory)
        guard story != nil else {return nil}

        return (story?.convertToStory())!
    }

    func update(record: StoryModel) -> Bool {

        let story = getCdStory(byId: record.idStory)
        print("record.idStory",record.idStory)
        guard story != nil else {return false}
        story?.content = record.content
        story?.title = record.title

        if(record.stickers != nil && record.stickers?.count != 0){
            var stickerSet = Set<StorySticker>()
            record.stickers?.forEach({ (sticker) in

                let cdSticker = StorySticker(context: PersistentStorage.shared.context)
                cdSticker.idStorySticker = sticker.idStorySticker
                print("id story sticker core data", cdSticker.idStorySticker)
                print("id sticker baru", sticker.idStorySticker)
                cdSticker.x = sticker.x
                cdSticker.y = sticker.y

                stickerSet.update(with: cdSticker)
            })
            
            story?.storySticker = stickerSet
        }

        PersistentStorage.shared.saveContext()
        
        return true
    }

    func delete(byIdentifier idStory: UUID) -> Bool {

        let story = getCdStory(byId: idStory)
        guard story != nil else {return false}

        PersistentStorage.shared.context.delete(story!)
        PersistentStorage.shared.saveContext()

        return true
    }

    private func getCdStory(byId idStory: UUID) -> Story?
    {
        let fetchRequest = NSFetchRequest<Story>(entityName: "Story")
        let fetchById = NSPredicate(format: "idStory == %@", idStory as CVarArg)
        fetchRequest.predicate = fetchById

        let result = try! PersistentStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}

        return result.first
    }

    typealias T = StoryModel



}

