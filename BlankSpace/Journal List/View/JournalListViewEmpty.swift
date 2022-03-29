//
//  JournalListViewEmpt.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 22/10/21.
//

import SwiftUI

struct JournalListViewEmpty: View{
    var searchCount: Int
    var filter: JournalListFilter
    
    var body: some View{
        if searchCount > 0 || filter.category.count > 0 || filter.moods.count > 0 {
            VStack {
                Image("Sad Document")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 220, maxHeight: 220)
                    .padding(.bottom, 20)
                Text("We can't find the entries you are looking for or maybe... you haven't wrote it?")
                    .font(.custom("DK Cool Crayon", size: 16))
                    .foregroundColor(Color("BackButtonGrey"))
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 20)
            .padding(.bottom, 70)
        }
        else {
            VStack {
                Image("Spider Web")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 260, maxHeight: 260)
                Text("You haven't had any journal entries yet, tap the button above to make one :)")
                    .font(.custom("DK Cool Crayon", size: 16))
                    .foregroundColor(Color("BackButtonGrey"))
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 70)
            .navigationBarHidden(true)
        }
    }
}

struct JournalListViewEmpty_Previews: PreviewProvider {
    static var previews: some View {
        JournalListViewEmpty(searchCount: 0, filter: JournalListFilter())
    }
}
