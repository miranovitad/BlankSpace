//
//  Encouragement.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 13/10/21.
//

import Foundation

struct Encouragement: Codable {
    let id, text: String
    let category: Category
}

enum Category: String, Codable {
    case negative = "negative"
    case positive = "positive"
}
