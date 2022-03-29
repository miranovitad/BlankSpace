//
//  StorySticker+CoreDataProperties.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//
//

import Foundation
import CoreData


extension StorySticker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StorySticker> {
        return NSFetchRequest<StorySticker>(entityName: "StorySticker")
    }

    @NSManaged public var idStorySticker: String?
    @NSManaged public var x: Int32
    @NSManaged public var y: Int32
    @NSManaged public var idStory: Story?

}
