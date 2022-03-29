//
//  JournalListViewModel.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 19/10/21.
//

//
//  JournalListViewModel.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 19/10/21.
//

import Foundation

final class JournalListViewModel: ObservableObject, RefreshableViewModel {
    
    @Published var filter = JournalListFilter()
    @Published var isPresented = false
    @Published var filteredEntries: [StoryModel]!
    
    let manager = StoryManager()
    var journalEntries: [StoryModel]!
//    var journalEntries:[StoryModel] = getDummy()
    
    
    @Published var searchText: String = "" {
        didSet {
            searchEntry()
        }
    }
    
    init() {
        self.journalEntries = getSavedStory()
        self.filteredEntries = journalEntries
    }
    
    func refresh() {
        isPresented = false
        filterEntry()
    }
    
    func reset() {
        filteredEntries = journalEntries
    }
    
    func filterEntry() {
        if !(filter.category.isEmpty && filter.moods.isEmpty) {
            let filteredEntry = journalEntries.filter { entry -> Bool in
                filter.category.contains(entry.aspect) || filter.moods.contains(entry.mood)
            }
            filteredEntries = filteredEntry
        }
        else {
            filteredEntries = journalEntries
        }
    }
    
    func searchEntry() {
        let query = searchText.lowercased()
        if query == "" {
            filteredEntries = journalEntries
            print(filter.category, filter.moods)
            filterEntry()
        }
        else {
            filteredEntries = filteredEntries.filter({ entry in
                entry.title.lowercased().contains(query) || entry.content.lowercased().contains(query)
            })
        }
    }
    
    func deleteStory(data: StoryModel) {
        let response = manager.delete(record: data)
        if response {
            print("deleted")
            filteredEntries = getSavedStory()
            return
        }
        print("Failed to delete", data)
    }
    
    func getSavedStory() -> [StoryModel] {
        let story = manager.getAll()
        var storyData: [StoryModel] = []
        
        story?.forEach({ (savedStory) in
            storyData.append(savedStory)
        })
        filteredEntries = storyData
        print("getSavedStory")
        return storyData
    }

    func sortStory(orderDes: Bool, filteredEntries: [StoryModel]) -> [StoryModel] {
        
        var storyData: [StoryModel] = []
        
        var a = filteredEntries
        
        if(orderDes == true) {
            a = a.sorted(by: {
                $0.date.compare($1.date) == .orderedDescending
            })
        } else {
            a = a.sorted(by: {
                $0.date.compare($1.date) == .orderedAscending
            })
        }
        
        a.forEach({ (savedStory) in
            storyData.append(savedStory)
        })
        
        return a
    }
    
    func getDummy() -> [StoryModel] {
        let sticker_1 = StoryStickerModel(_idStorySticker: "4", _x: 0, _y: 0)
        let sticker_2 = StoryStickerModel(_idStorySticker: "5", _x: 0, _y: 0)
        let sticker_3 = StoryStickerModel(_idStorySticker: "8", _x: 0, _y: 0)
        let sticker_4 = StoryStickerModel(_idStorySticker: "2", _x: 0, _y: 0)
        
        let story_1 = StoryModel(_idStory: UUID(), _date: Date(), _mood: .bad, _aspect: .study, _title: "What have you done for fun today?", _content: "Hi! this is content of What have you done for fun today?", _stickers: [sticker_1, sticker_2])
        let story_2 = StoryModel(_idStory: UUID(), _date: Date(), _mood: .kindabad, _aspect: .future, _title: "What is your biggest regret in life so far?", _content: "Hi! this is content of What is your biggest regret in life so far?", _stickers: [sticker_3, sticker_4])
        let story_3 = StoryModel(_idStory: UUID(), _date: Date(), _mood: .kindagood, _aspect: .study, _title: "What you learn today?", _content: "Hi! this is content of What you learn today?", _stickers: [sticker_4])
        
        return [story_1, story_2, story_3]
    }
}
