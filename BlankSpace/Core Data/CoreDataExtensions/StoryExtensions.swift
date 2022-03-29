//
//  StoryExtensions.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 23/10/21.
//

import Foundation

extension Story
{
    func convertToStory() -> StoryModel
    {
        return StoryModel(_idStory: self.idStory!, _date: self.date!, _mood: Mood(rawValue: self.mood!)!, _aspect: PromptCategory(rawValue: self.aspect!)!, _title: self.title!, _content: self.content!, _stickers: self.convertToStickers())
    }

    private func convertToStickers() -> [StoryStickerModel]?
    {
        guard self.storySticker != nil && self.storySticker.count != 0 else {return nil}

        var stickers: [StoryStickerModel] = []

        self.storySticker.forEach({ (sticker) in
            stickers.append(sticker.convertToSticker())
        })

        return stickers
    }
}

