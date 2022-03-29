//
//  StoryModel.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//

import Foundation

class StoryModel: ObservableObject, Identifiable, Equatable {
    
    static func == (lhs: StoryModel, rhs: StoryModel) -> Bool {
        return lhs.idStory == rhs.idStory
    }
    
    @Published var idStory: UUID
    @Published var date: Date
    @Published var mood: Mood
    @Published var aspect: PromptCategory
    @Published var title: String
    @Published var content: String
    @Published var stickers: [StoryStickerModel]?
    
    init(_idStory: UUID, _date: Date, _mood: Mood, _aspect: PromptCategory, _title: String, _content: String, _stickers: [StoryStickerModel]? = nil) {
        self.idStory = _idStory
        self.date = _date
        self.mood = _mood
        self.aspect = _aspect
        self.title = _title
        self.content = _content
        self.stickers = _stickers
    }
    
}
