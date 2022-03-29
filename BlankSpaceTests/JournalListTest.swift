//
//  JournalList.swift
//  BlankSpaceTests
//
//  Created by Bryan Khufa on 22/10/21.
//

import XCTest
@testable import BlankSpace

class JournalListTest: XCTestCase {
    
    var sut: JournalListViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = JournalListViewModel()
        
        let sticker_1 = StoryStickerModel(_idStorySticker: "4", _x: 0, _y: 0)
        let sticker_2 = StoryStickerModel(_idStorySticker: "5", _x: 0, _y: 0)
        let sticker_3 = StoryStickerModel(_idStorySticker: "8", _x: 0, _y: 0)
        let sticker_4 = StoryStickerModel(_idStorySticker: "2", _x: 0, _y: 0)
        
        sut.journalEntries = [
        StoryModel(_idStory: UUID(), _date: Date(), _mood: .bad, _aspect: .study, _title: "What have you done for fun today?", _content: "Hi! this is content of What have you done for fun today?", _stickers: [sticker_1, sticker_2]),
        StoryModel(_idStory: UUID(), _date: Date(), _mood: .kindabad, _aspect: .future, _title: "What is your biggest regret in life so far?", _content: "Hi! this is content of What is your biggest regret in life so far?", _stickers: [sticker_3, sticker_4]),
        StoryModel(_idStory: UUID(), _date: Date(), _mood: .kindagood, _aspect: .study, _title: "What you learn today?", _content: "Hi! this is content of What you learn today?", _stickers: [sticker_4])
        ]
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testRefresh() {
        sut.isPresented = true
        sut.refresh()
        XCTAssertFalse(sut.isPresented)
    }
    
    func testReset() {
        sut.filteredEntries = []
        sut.reset()
        XCTAssertEqual(sut.filteredEntries, sut.journalEntries, "Beda isi stickernya")
    }
    
    func testFilterEntry1() {
        sut.filter.moods = [.bad]
        sut.filter.category = []
        
        
        sut.filterEntry()
        
        XCTAssertEqual(sut.filteredEntries, [sut.journalEntries[0]], "Semua tak sama, tak pernah sama")
        XCTAssertEqual(sut.filteredEntries.count, 1, "Beda ukuran")
    }
    
    func testFilterEntry2() {
        sut.filter.moods = [.kindagood]
        sut.filter.category = [.study]
        
        sut.filterEntry()
        
        XCTAssertEqual(sut.filteredEntries, [sut.journalEntries[0], sut.journalEntries[2]], "Semua tak sama, tak pernah sama")
        XCTAssertEqual(sut.filteredEntries.count, 2)
    }
    
    func testSearch() {
        sut.searchText = "doNE"
        sut.filteredEntries = sut.journalEntries
        
        sut.searchEntry()
        XCTAssertEqual(sut.filteredEntries, [sut.journalEntries[0]], "Beda isi")
        
        
        sut.searchText = ""
        sut.filteredEntries = sut.journalEntries
        
        sut.searchEntry()
        XCTAssertEqual(sut.filteredEntries, sut.journalEntries, "Beda isi")
    }
    
    func testSearchAndFilter() {
        sut.searchText = "doNE"
        sut.filteredEntries = sut.journalEntries
        
        sut.searchEntry()
        XCTAssertEqual(sut.filteredEntries, [sut.journalEntries[0]], "Beda isi")
    }
    
}
