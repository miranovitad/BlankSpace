//
//  AlertView.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 26/10/21.
//

import SwiftUI

struct AlertBuyView: View {
    @Binding var showAlert: Bool
    var sticker: StickerStruct
    @Binding var point: Int32
    @ObservedObject var viewModelSticker: StickerShopViewModel
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    self.showAlert.toggle()
                }) {
                    Image(systemName: "xmark")
                }
                .font(Font.system(size: 16, weight: .bold))
                .frame(width: 25, height: 25, alignment: .center)
                .background(Color("BGColor"))
                .foregroundColor(Color.white)
                .cornerRadius(100)
            }.padding(10)
            Text("Do you want to purchase this sticker?")
                .font(.custom("DK Cool Crayon", size: 16))
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Image(sticker.fileName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100, maxHeight: 100)
            HStack{
                Text("\(sticker.price)")
                    .font(.custom("DK Cool Crayon", size: 16))
                    .foregroundColor(Color("BGColor"))
                Image("Coin").resizable().frame(maxWidth: 20, maxHeight: 20, alignment: .leading).scaledToFit()
                
            }
//            HStack{
//                Text("\(viewModel.filteredStickers.fileName)")
//                    .font(.custom("DK Cool Crayon", size: 18))
//                    .foregroundColor(Color("BGColor"))
//                Image("Coin").resizable().frame(width: 10, height: 10, alignment: .leading)
//            }
            Spacer()
            Button(action: {
                
                let managerOwnedSticker = OwnedStickerManager()
                let ownedStickerData = OwnedStickerModel(_buyDate: Date(), _idSticker: sticker.id)
                let resultOwnedSticker = managerOwnedSticker.createOwnedSticker(record: ownedStickerData)
                
                if(resultOwnedSticker == true) {
                    let manager = UserPointManager()
                    let userPointData = UserPointModel(_idTrans: UUID(), _amount: Int32(sticker.price), _category: "-", _currentPoint: (point-Int32(sticker.price)), _date: Date(), _note: "Sticker Purchase")
                    let result = manager.createUserPoint(record: userPointData)
                    
                    if(result == true) {
                        debugPrint("Purchase success")
                        self.showAlert.toggle()
                        point = viewModelSticker.getCurrentPoint()
                    } else {
                        debugPrint("Purchase failed")
                    }
                    
                } else {
                    debugPrint("Purchase process failed")
                }
                
            }) {
                ZStack{
                    Image("PromptButton")
                        .resizable()
                        .frame(width: 150, height: 50, alignment: .center)
                    Text("Buy")
                        .font(.custom("DK Cool Crayon", size: 18))
                        .foregroundColor(Color.white)
                }
            }.padding()
        }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.5)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

//            .shadow(color: .gray, radius: 12, x: 0, y: 0)
    }
}

