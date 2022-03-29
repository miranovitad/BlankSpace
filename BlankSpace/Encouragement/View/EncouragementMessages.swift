//
//  EncouragementMessages.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 04/11/21.
//

import SwiftUI

struct EncouragementMessages: View {
    @Binding var streakCount: Int
    @Binding var encouragementMessages: Bool
    var body: some View {
        if streakCount <= 3{
            VStack{
                Text("Don’t worry, your secret is save with me :) ")
                    .font(.custom("DK Cool Crayon", size: 20))
                    .multilineTextAlignment(.center)
                    .padding(.top, 100)
                HStack{
                    Text("+" + "25")
                        .font(.custom("DK Cool Crayon", size: 16))
                        .foregroundColor(Color("BGColor"))
                    Image("Coin").resizable().frame(maxWidth: 30, maxHeight: 30, alignment: .leading).scaledToFit()
                }.padding(.top, 30)
                Spacer()
                Button(action: {
                    streakCount = +1
                    encouragementMessages = true
                }) {
                    ZStack{
                        Image("PromptButton")
                            .resizable()
                            .frame(width: 150, height: 50, alignment: .center)
                        Text("OK")
                            .font(.custom("DK Cool Crayon", size: 18))
                            .foregroundColor(Color.white)
                    }
                }.padding()
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.4)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .navigationBarHidden(true)
            //            .shadow(color: .gray, radius: 12, x: 0, y: 0)
        }
        else if streakCount == 4{
            VStack{
                Text("You are so brave for speaking up about your problem!")
                    .font(.custom("DK Cool Crayon", size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                Text("Here’s some rewards for you!")
                    .font(.custom("DK Cool Crayon", size: 16))
                    .multilineTextAlignment(.center)
                Text("+ New Sticker")
                    .font(.custom("DK Cool Crayon", size: 16))
                    .foregroundColor(Color("BGColor"))
                    .multilineTextAlignment(.center)
                    .padding()
                Image("Bu Dokter") // Update Sticker Progress
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 10,maxHeight: 100)
                HStack{
                    Text("+" + "25")
                        .font(.custom("DK Cool Crayon", size: 16))
                        .foregroundColor(Color("BGColor"))
                    Image("Coin").resizable().frame(maxWidth: 30, maxHeight: 30, alignment: .leading).scaledToFit()
                }
                Button(action: {
                    streakCount = 0
                    encouragementMessages = true
                }) {
                    ZStack{
                        Image("PromptButton")
                            .resizable()
                            .frame(width: 150, height: 50, alignment: .center)
                        Text("OK")
                            .font(.custom("DK Cool Crayon", size: 18))
                            .foregroundColor(Color.white)
                    }
                }.padding()
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .navigationBarHidden(true)
            //            .shadow(color: .gray, radius: 12, x: 0, y: 0)
        }
    }
}

//struct EncouragementMessages_Previews: PreviewProvider {
//    static var previews: some View {
//        EncouragementMessages(journalStreak: .constant(true))
//    }
//}
