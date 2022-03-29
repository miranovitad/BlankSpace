//
//  RandomizePromptViewModel.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 05/10/21.
//

import Foundation

final class RandomizePromptViewModel: ObservableObject {
    var prompts: [Prompt]
    @Published var contextualizedPrompt: [Prompt] = []
    var category: Set<PromptCategory>
    
    @Published var prompt: String = ""
    
    init(context: Set<PromptCategory>) {
        self.prompts = ModelData.loadJson("prompt.json")
        self.category = context
        contextualPrompt(things: context)
//        print(context)
    }
    
    func randomizePrompt(isContextual: Bool) {
        if !isContextual {
            let id = Int.random(in: 0...prompts.count-1)
            prompt = prompts[id].text
        }
        else {
            contextualPrompt(things: category)
        }
    }
    
    func contextualPrompt(things: Set<PromptCategory>) {
        var defaultEmotion: Set<PromptCategory> = []
        defaultEmotion.formUnion(things)
        contextualizedPrompt = prompts.filter { item -> Bool in
            defaultEmotion.contains(item.aspect)
        }
        let id = Int.random(in: 0...contextualizedPrompt.count-1)
        prompt = contextualizedPrompt[id].text
    }
}
