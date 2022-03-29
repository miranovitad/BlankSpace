//
//  AlertCancelBuyView.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 28/10/21.
//

import SwiftUI

struct AlertCancelBuyView: View {
    //        @ObservedObject var viewModel: ShopViewModel
    @Binding var showAlert: Bool
    var sticker: StickerStruct
    
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
            Text("You don’t have enough coins right now, keep doin your journaling and get some coins")
                .font(.custom("DK Cool Crayon", size: 16))
                .multilineTextAlignment(.center)
                .padding()
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
            .padding()
        }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.4)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        //            .shadow(color: .gray, radius: 12, x: 0, y: 0)
    }
}
//struct AlertCancelBuyView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlertCancelBuyView(showAlert: .constant(false))
//    }
//}
