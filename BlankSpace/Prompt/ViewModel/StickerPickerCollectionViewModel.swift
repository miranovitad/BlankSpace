//
//  StickerPickerCollectionView.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 13/10/21.
//

import Foundation
import SwiftUI

final class StickerPickerCollectionViewModel: ObservableObject {
    

    let stickers = ModelData.stickers
    @Published var activeStckr: [StickerStruct] = []

}
