//
//  Story+CoreDataProperties.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//
//

import Foundation
import CoreData


extension Story {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Story> {
        return NSFetchRequest<Story>(entityName: "Story")
    }

    @NSManaged public var aspect: String?
    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var idStory: UUID?
    @NSManaged public var mood: String?
    @NSManaged public var title: String?
    @NSManaged public var storySticker: Set<StorySticker>

}

// MARK: Generated accessors for storySticker
extension Story {

    @objc(addStoryStickerObject:)
    @NSManaged public func addToStorySticker(_ value: StorySticker)

    @objc(removeStoryStickerObject:)
    @NSManaged public func removeFromStorySticker(_ value: StorySticker)

    @objc(addStorySticker:)
    @NSManaged public func addToStorySticker(_ values: Set<StorySticker>)

    @objc(removeStorySticker:)
    @NSManaged public func removeFromStorySticker(_ values: Set<StorySticker>)

}
