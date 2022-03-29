//
//  AlertOwnedView.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 28/10/21.
//

import SwiftUI

struct AlertOwnedView: View {
    @Binding var showAlertOwned: Bool
    var sticker: StickerStruct
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    self.showAlertOwned.toggle()
                }) {
                    Image(systemName: "xmark")
                }
                .font(Font.system(size: 16, weight: .bold))
                .frame(width: 25, height: 25, alignment: .center)
                .background(Color("BGColor"))
                .foregroundColor(Color.white)
                .cornerRadius(100)
            }.padding(10)
            Spacer()
            Image(sticker.fileName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100, maxHeight: 100)
            Text(sticker.name)
                .font(.custom("DK Cool Crayon", size: 16))
            Spacer()
        }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.4)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        //            .shadow(color: .gray, radius: 12, x: 0, y: 0)
    }
}
