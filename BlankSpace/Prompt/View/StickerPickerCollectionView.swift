//
//  StickerPickerCollectionView.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 13/10/21.
//

import Foundation
import SwiftUI

struct StickerPickerCollectionView: View {
    
    var gridItemLayout = [ GridItem(.adaptive(minimum: 50))]
    var nCoulmnGrid: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    let viewModel : StickerShopViewModel
    @Binding var activeStickers: [StickerStruct]
    @Binding var modalStatus: Bool
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: nCoulmnGrid, spacing: 10) {
                ForEach(viewModel.getOwnedSticker(), id: \.self) {
                    StickerItem(sticker: $0, activeStickers: $activeStickers, modalStatus: $modalStatus)
                }
            }
        }
    }
}

struct StickerItem: View {
    let sticker: StickerStruct
    //    TODO: Refactor biar MVVM
    //    let addSticker: (StickerStruct) -> ()
    @Binding var activeStickers: [StickerStruct]
    @State var showAlert = false
    @Binding var modalStatus: Bool
    
    var body: some View {
        Button(action: {
            if (activeStickers.count < 2) {
                activeStickers.append(sticker)
            } else {
                self.showAlert = true
            }
        }, label: {
            VStack {
                Image(sticker.fileName)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: 90)
                    .cornerRadius(10)                
            }
        })
        .alert(isPresented: $showAlert) { () -> Alert in
            Alert(title: Text("Opss, maximum sticker"), message: Text("You can only choose two stickers for your journal. Choose two stickers that best represent your day"), primaryButton: .default(Text("Okay"), action: {
                modalStatus = false
            }), secondaryButton: .default(Text("Dismiss")))
            
        }
        .buttonStyle(PlainButtonStyle())
    }
}
