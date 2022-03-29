//
//  BlankSpaceApp.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 30/09/21.
//

import SwiftUI

@main
struct BlankSpaceApp: App {
    @State private var show: Bool = false
    @State var name: String = UserDefaults.standard.string(forKey: "Name") ?? ""
    var body: some Scene {
        WindowGroup {
            if name == "" {
                OnboardingView().preferredColorScheme(.light)
            } else {
                MainView(showEncouragement: false).preferredColorScheme(.light)
            }
//             MainView(showEncouragement: false)
                
//            JournalListView(searchText: .constant("nasi"))
//            MiraTest()
//            StickerShopView(searchText: .constant(""))
//            JournalList()
//            CanvasView()
//            CobaanLagi()
//            KeyboardToolBar()
        }
    }
}
//FFC511E5-8764-4A29-B9C4-C36BDF8B5AC6
//73DDFDAE-B025-498B-B117-6A10064C1840
//650AC200-FD84-451C-B622-B40288BF0B66
//47B0DF25-2A7C-4569-BF75-CA58D62B69CD
