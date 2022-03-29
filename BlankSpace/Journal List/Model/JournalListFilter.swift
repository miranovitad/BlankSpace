//
//  JournalListFilter.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 19/10/21.
//

import Foundation

struct JournalListFilter {    
    var moodIndex: Set<Int> = []
    var categoryIndex: Set<Int> = []
    
    var moods: Set<Mood> = []
    var category: Set<PromptCategory> = []
}
