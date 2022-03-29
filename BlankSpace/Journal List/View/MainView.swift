//
//  JournalListView.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 18/10/21.
//

import SwiftUI
import HalfASheet

struct MainView: View {
    
    let showEncouragement: Bool
    
    var body: some View {
        NavigationView {
            TabView{
                JournalListView(showEncouragement: showEncouragement).tabItem{
                    Image(systemName: "doc.plaintext.fill").padding(.top, 15)
                    Text("Journal List")
                }
                StickerShopView().tabItem {
                    Image(systemName: "bag.fill").padding(.top, 15)
                    Text("Shop")
                }
                
            }
            .tabViewStyle(backgroundColor: .appColorLightGrey.opacity(0.3),
                          itemColor: .appColorGrey,
                          selectedItemColor: .appColorPrimary,
                          badgeColor: .appColorPrimary)
        }.navigationBarHidden(true)
    }
}
