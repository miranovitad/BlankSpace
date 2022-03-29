//
//  Prompt.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 04/10/21.
//

import Foundation

struct Prompt: Decodable, Equatable, Hashable {
    let id, text: String
    let aspect: PromptCategory
}

enum PromptCategory: String, Codable, CaseIterable {
    case others = "Others"
    case hobby = "Hobby"
    case friend = "Friend"
    case relationship = "Relationship"
    case family = "Family"
    case future = "Future"
    case work = "Work"
    case study = "Study"
    case health = "Health"
    case finance = "Finance"
}

class CurrentPrompt: ObservableObject {
    
    @Published var count: Int = 0
    @Published var allPrompt: [String] = []
    @Published var currentPrompt: String = ""
    @Published var loopCount: Int = 0
    
}
