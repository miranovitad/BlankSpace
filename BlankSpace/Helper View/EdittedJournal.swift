//
//  EdittedJournal.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 11/11/21.
//

import SwiftUI

struct EdittedJournal: View {
    @Binding var doneButton: Bool
    var body: some View {
        ZStack{
            VStack{
                Text("Journal Has Been Saved!")
                    .font(.custom("DK Cool Crayon", size: 20))
                    .multilineTextAlignment(.center)
                    .padding()
                NavigationLink(destination: JournalListView(showEncouragement: false), isActive: $doneButton){
                    Button(action: {
                        self.doneButton.toggle()
                    }) {
                        ZStack{
                            Image("PromptButton")
                                .resizable()
                                .frame(width: 150, height: 50, alignment: .center)
                            Text("Ok")
                                .font(.custom("DK Cool Crayon", size: 18))
                                .foregroundColor(Color.white)
                        }
                    }
                }
            }
        }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.4)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .navigationBarHidden(true)
    }
}

//struct EdittedJournal_Previews: PreviewProvider {
//    static var previews: some View {
//        EdittedJournal()
//    }
//}
