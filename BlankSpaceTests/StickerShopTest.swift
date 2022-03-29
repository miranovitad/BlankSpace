//
//  StickerShopTest.swift
//  BlankSpaceTests
//
//  Created by Bryan Khufa on 25/10/21.
//

import XCTest
@testable import BlankSpace

class StickerShopTest: XCTestCase {
    
    var sut: StickerShopViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = StickerShopViewModel()
        sut.stickers = [
            StickerStruct(id: "1", name: "Halo", fileName: "halo", url: "", price: 200, keyword: "squid game, foods", category: "Family, Hobby"),
            StickerStruct(id: "2", name: "Nama", fileName: "nama", url: "", price: 200, keyword: "foods", category: "Work"),
            StickerStruct(id: "3", name: "Saya", fileName: "saya", url: "", price: 200, keyword: "person", category: "Hobby"),
            StickerStruct(id: "4", name: "Refo", fileName: "refo", url: "", price: 200, keyword: "person", category: "Study, Hobby"),
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
        sut.filteredData = []
        sut.reset()
        XCTAssertEqual(sut.filteredData, sut.stickers, "Beda isi stickernya")
    }
    
    func testFilterSticker() {
        var filter = JournalListFilter(moodIndex: [], categoryIndex: [], moods: [.bad], category: [.family])
        
        let result1 = sut.filterData(sut.stickers, filter: filter)
        XCTAssertEqual(result1, [sut.stickers[0]], "Beda isinya")
        XCTAssertEqual(result1.count, 1, "Beda jumlah")
        
        filter = JournalListFilter(moodIndex: [], categoryIndex: [], moods: [.bad], category: [.hobby, .work])
        let result2 = sut.filterData(sut.stickers, filter:filter)
        XCTAssertEqual(result2, [sut.stickers[0], sut.stickers[1], sut.stickers[2], sut.stickers[3]], "Beda isinya")
        XCTAssertEqual(result2.count, 4, "Beda jumlah")
    }

}
