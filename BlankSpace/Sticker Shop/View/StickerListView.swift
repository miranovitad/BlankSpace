//
//  StickerListView.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 25/10/21.
//

import SwiftUI

struct StickerListView: View {
    @ObservedObject var viewModel: StickerShopViewModel
    @Binding var stickerAlertBuy : Bool
    @State var activeBuySticker: StickerStruct = StickerStruct(id: "1",name: "", fileName: "", url: "", price: 100, keyword: "", category: "" )
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @Binding var currentPoint: Int32
    @State var stickerPrice: Int = 0
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVGrid(columns: gridItemLayout, spacing: 20){
                    ForEach((viewModel.filteredData), id: \.self) { sticker in
                        Button(action: {
                            if viewModel.ownedStickerId().contains(sticker.id) {
                                debugPrint("Owned")
                            } else {
                                self.stickerAlertBuy.toggle()
                            }
                            activeBuySticker = sticker
                            print(sticker.id)
                            stickerPrice = sticker.price
                        }) {
                            VStack(alignment: .center, spacing: 1){
                                Image(sticker.fileName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 100, alignment: .center)
                                Text(sticker.name)
                                    .foregroundColor(.black)
                                if viewModel.ownedStickerId().contains(sticker.id) {
                                    Text("Owned")
                                        .font(.custom("DK Cool Crayon", size: 14))
                                        .foregroundColor(Color.gray)
                                } else {
                                    HStack{
                                        Text("\(sticker.price)")
                                            .font(.custom("DK Cool Crayon", size: 18))
                                            .foregroundColor(Color("BGColor"))
                                        Image("Coin").resizable().frame(width: 20, height: 20, alignment: .leading).scaledToFit()
                                    }.padding(.horizontal, 0)
                                }
                            }
                        }.disabled(stickerAlertBuy)
                    }
                }
            }
            .onAppear {
                print("Currentpoint: ", currentPoint)
                print(viewModel.ownedStickerId())
            }
            if stickerAlertBuy == true {
                Rectangle()
                    .fill(Color.appColorGrey)
                    .opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        stickerAlertBuy = false
                    }
                if currentPoint >= stickerPrice {
                    AlertBuyView(showAlert: $stickerAlertBuy, sticker: activeBuySticker, point: $currentPoint, viewModelSticker: viewModel)
                }
                else {
                    AlertCancelBuyView(showAlert: $stickerAlertBuy, sticker: activeBuySticker)
                }
            }
        }
    }
}
