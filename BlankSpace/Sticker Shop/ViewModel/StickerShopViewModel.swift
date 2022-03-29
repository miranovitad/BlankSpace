//
//  ShopViewModel.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 25/10/21.
//

import Foundation

final class StickerShopViewModel: ObservableObject, RefreshableViewModel {
    
    var filter = JournalListFilter()
    
    @Published var isPresented = false
    var stickers: [StickerStruct] = ModelData.stickers
    @Published var filteredData: [StickerStruct]

    @Published var searchText: String = "" {
        didSet {
            searchEntry()
        }
    }
    
    init() {
        self.filteredData = stickers
    }
    
    func refresh() {
        isPresented = false
        filteredData = filterData(stickers, filter: filter)
    }
    
    func reset() {
        filteredData = stickers
    }
    
    func filterData(_ data: [StickerStruct], filter: JournalListFilter) -> [StickerStruct] {
        if !(filter.category.isEmpty && filter.moods.isEmpty) {
            let filtered = data.filter { item in
                filter.category.intersection(item.stickerCategory()).count > 0
            }
            return filtered
        }
        else {
            return data
        }
    }

    func searchEntry() {
        let query = searchText.lowercased()
        if query == "" {
            filteredData = stickers
            print(filter.category, filter.moods)
            filteredData = filterData(stickers, filter: filter)
        }
        else {
            filteredData = filteredData.filter({ entry in
                entry.name.lowercased().contains(query) || entry.keyword.lowercased().contains(query)
            })
        }
    }
    
    func getOwnedSticker() -> [StickerStruct] {
        
        let manager = OwnedStickerManager()
        let ownedSticker = manager.getAll()
        let stickerJson = ModelData.stickers
        
        var ownedStickerArray: [StickerStruct] = [ModelData.stickers[0], ModelData.stickers[1]]
        
        ownedSticker?.forEach({ (ownedItem) in
            for sticker in stickerJson {
                if ownedItem.idSticker == sticker.id {
                    ownedStickerArray.append(StickerStruct(id: sticker.id, name: sticker.name, fileName: sticker.fileName, url: sticker.url, price: sticker.price, keyword: sticker.keyword, category: sticker.category))
                }
            }
        })
        
        return ownedStickerArray
    }
    
    func ownedStickerId() -> [String] {
        let manager = OwnedStickerManager()
        let ownedSticker = manager.getAll()
        var ownedStickerIdArray: [String] = ["1","2"]
        
        ownedSticker?.forEach({ (ownedItem) in
            ownedStickerIdArray.append(ownedItem.idSticker)
        })
        
        return ownedStickerIdArray
    }
    
    func getCurrentPoint() -> Int32 {
        
        let manager = UserPointManager()
        let userPoint = manager.getAll()
        let lastDate: Date = Date(timeIntervalSince1970: 0)
        var currentPoint: Int32 = 300

        userPoint?.forEach({ (item) in
            if item.date > lastDate {
                currentPoint = item.currentPoint
            }
        })
        
        return currentPoint
    }
}

