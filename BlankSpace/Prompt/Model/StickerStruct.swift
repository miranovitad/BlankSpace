//
//  Sticker.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 13/10/21.
//

import Foundation

struct StickerStruct: Decodable, Hashable {
    var id, name, fileName, url: String
    let price: Int
    let keyword, category: String
    
    private enum CodingKeys: String, CodingKey { case id, name, fileName, url, price, keyword, category}
    
    func stickerKeyword() -> [String] {
        return keyword.components(separatedBy: ", ")
    }

    func stickerCategory() -> Set<PromptCategory> {
        return Set(category.components(separatedBy: ", ").map({ item in
            (PromptCategory(rawValue: item) ?? .others)
        }))
    }
}
