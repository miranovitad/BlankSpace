//
//  JournalEntry.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 21/10/21.
//

import Foundation

struct JournalEntry: Hashable{
    let id: Int
    let title: String
    let mood: Mood
    let category:PromptCategory
    let date: Date
    let sticker: [StickerStruct]
}
