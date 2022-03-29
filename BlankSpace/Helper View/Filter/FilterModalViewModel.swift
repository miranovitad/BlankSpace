//
//  FilterModalViewModel.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 19/10/21.
//

import Foundation
import SwiftUI

protocol RefreshableViewModel {
    func refresh()
    func reset()
    var filter: JournalListFilter { get set }
}

final class FilterModalViewModel: ObservableObject {
    
    @Published var viewModelToRefresh: RefreshableViewModel
    @Published var isPresented = false
    
    let moodString: [String] = Mood.allCases.map { $0.rawValue }
    let categoryString: [String] = PromptCategory.allCases.map { $0.rawValue }.sorted()
    

    init(parentViewModel: RefreshableViewModel) {
        self.viewModelToRefresh = parentViewModel
    }
    
    
    func applyFilter() {
        
        viewModelToRefresh.filter.moods = Set(viewModelToRefresh.filter.moodIndex.map({ (idx) -> Mood in
            (Mood(rawValue: moodString[idx]) ?? Mood.allCases[idx])
        }))
        viewModelToRefresh.filter.category = Set(viewModelToRefresh.filter.categoryIndex.map({ (idx) -> PromptCategory in
            (PromptCategory(rawValue: categoryString[idx]) ?? PromptCategory.allCases[idx])
        }))
        
        viewModelToRefresh.refresh()
    }
    
    func resetFilter() {
        viewModelToRefresh.filter.moodIndex.removeAll()
        viewModelToRefresh.filter.categoryIndex.removeAll()
        viewModelToRefresh.reset()
    }
}
