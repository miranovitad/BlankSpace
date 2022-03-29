//
//  StickerOwnedListView.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 28/10/21.
//

import SwiftUI

struct StickerOwnedListView: View {
    @ObservedObject var viewModel: StickerShopViewModel
    @Binding var stickerAlertOwned : Bool
    @State var activeBuySticker: StickerStruct = StickerStruct(id: "1",name: "", fileName: "", url: "", price: 100, keyword: "", category: "" )
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack{
            ScrollView{
                LazyVGrid(columns: gridItemLayout, spacing: 20){
                    ForEach((viewModel.getOwnedSticker()), id: \.self) { sticker in
                        Button(action: {
                            self.stickerAlertOwned.toggle()
                            activeBuySticker = sticker
                            print("Masuk Owned")
                        }) {
                            VStack(alignment: .center, spacing: 1){
                                Image(sticker.fileName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 100, alignment: .center)
                                Text(sticker.name)
                                    .foregroundColor(.black)
                            }
                        }.disabled(stickerAlertOwned)
                    }
                }
            }
            if stickerAlertOwned == true {
                Rectangle()
                    .fill(Color.appColorGrey)
                    .opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture {
                        stickerAlertOwned = false
                    }
                AlertOwnedView(showAlertOwned: $stickerAlertOwned, sticker: activeBuySticker)
            }
        }
    }
}
