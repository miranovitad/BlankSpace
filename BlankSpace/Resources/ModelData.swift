//
//  ModelData.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 04/10/21.
//

import Foundation

class ModelData {
    static let prompts: [Prompt] = loadJson("prompt.json")
    static let stickers: [StickerStruct] = loadJson("sticker.json")
    static let encouragements: [Encouragement] = loadJson("encouragement.json")
    
    static func loadJson<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            print("decoding json", filename)
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
