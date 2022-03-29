//
//  CobaMira.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 24/10/21.
//

import Foundation
import SwiftUI

struct MiraTest: View {

    var body: some View {
        Text("")
        Button(action: {
            print(getSavedOwnedSticker())
        }) {
            Text("Cek data")
        }
        .font(Font.system(size: 20, weight: .bold))
        .background(Color("BGColor"))
        .foregroundColor(Color.white)
        .onAppear{
            getSavedStory()
//            let manager = UserPointManager()
//
//            let userPointData = UserPointModel(_idTrans: UUID(), _amount: 300, _category: "+", _currentPoint: 300, _date: Date(), _note: "Finish journaling point")
//
//            let result = manager.createUserPoint(record: userPointData)
//
//            if(result == true)
//            {
//                debugPrint("record saved successfully")
//            }
//            else
//            {
//                debugPrint("Create failed")
//            }
            
            
//            let manager = OwnedStickerManager()
//
//            let ownedStickerData = OwnedStickerModel(_buyDate: Date(), _idSticker: "2")
//
//            let result = manager.createOwnedSticker(record: ownedStickerData)
//
//            if(result == true)
//            {
//                debugPrint("record saved successfully")
//            }
//            else
//            {
//                debugPrint("Create failed")
//            }

        }
    }
    
}
func getSavedStory() {
    
    let manager = StoryManager()
    let userPoint = manager.getAll()
    
    userPoint?.forEach({ (savedPoint) in
        print(savedPoint.idStory)
        
    })
}
func getSavedUserPoint() {
    
    let manager = UserPointManager()
    let userPoint = manager.getAll()
    
    userPoint?.forEach({ (savedPoint) in
        print(savedPoint.idTrans)
        print(savedPoint.date)
        print(savedPoint.category)
        print(savedPoint.amount)
        print(savedPoint.note)
        print(savedPoint.currentPoint)
    })
}

func getSavedOwnedSticker() {
    
    let manager = OwnedStickerManager()
    let ownedSticker = manager.getAll()
    
    ownedSticker?.forEach({ (savedSticker) in
        print(savedSticker.idSticker)
        print(savedSticker.buyDate)
    })
}
