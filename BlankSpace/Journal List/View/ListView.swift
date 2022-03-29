//
//  ListVieww.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 22/10/21.
//

import SwiftUI

struct ListView: View{
    
    private var title: String
    private var mood: Mood
    private var aspect: PromptCategory
    private var date: Date
    private var stickers: [StoryStickerModel?]
    
    init(title: String, mood: Mood, aspect: PromptCategory, date: Date, sticker: [StoryStickerModel?]) {
        self.title = title
        self.mood = mood
        self.aspect = aspect
        self.date = date
        self.stickers = sticker
    }
    
    @State var imageSticker: String = "Monyet"
    
    var body: some View{
        ZStack {
            Color.white
                .cornerRadius(12)
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.custom("DK Cool Crayon", size: 18))
                        .multilineTextAlignment(.leading)
                    Text(mood.rawValue + " - " + aspect.rawValue)
                        .font(.system(size: 10))
                    Text(Formatter.changeDateFormat(date: date))
                        .font(.system(size: 10))
                }
                Spacer()
                Image(imageSticker)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 80, maxHeight: 80)
            }
            .padding()
            .onAppear {
                imageSticker = getStickerName(dataSticker: stickers)
            }
        }
        .foregroundColor(Color.black)
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 20)
        .padding(.bottom, 14)
    }
}


func getStickerName(dataSticker: [StoryStickerModel?]) -> String{
    
    let stickerJson = ModelData.stickers
    var stickerArrary: [String] = []
    
    for item in dataSticker {
        for sticker in stickerJson {
            if item?.idStorySticker == sticker.id {
                stickerArrary.append(sticker.fileName)
            }
        }
    }
    if stickerArrary.isEmpty{
        return ""
    }
    
    return stickerArrary[0]
}

//struct ListView: View{
//    var journalEntry : [JournalEntry]
//
//    @State var activePrompt: Prompt = ModelData.prompts[0] //ijin ngambil dari mira wkwkwk
//
//    var body: some View{
//        LazyVStack(spacing: 20){
//            ForEach(journalEntry, id:\.self){item in
//                NavigationLink(destination: CanvasView()) {
//                    HStack{
//                        VStack(alignment: .leading){
//                            Text(item.title)
//                                .font(.custom("DK Cool Crayon", size: 18))
//                                .multilineTextAlignment(.leading)
//                            Spacer()
//                            HStack{
//                                Text(item.mood.rawValue + " - " + item.category.rawValue)
//                            }.font(.system(size: 10))
//                            Text("18 Oct 2021")
//                                .font(.system(size: 10))
//                        }
//                        Spacer()
//                        Image("Squid Guard A")
//                            .resizable()
//                            .frame(width: 50, height: 80)
//                            .padding(.trailing, 10)
//                    }.frame(width:300)
//                }
//            }
//            .padding(.horizontal, 20)
//            .padding(.vertical, 10)
//            .foregroundColor(Color.black)
//            .frame(height: 120)
//            .background(Color.white)
//            .cornerRadius(20)
//            .clipped()
//            .shadow(color: .gray, radius: 2, x: 0, y: 1)
//        }
////        .environment(\.defaultMinListRowHeight, 50)
//    }
//}

//struct ListView: View{
//    var journalEntry : [JournalEntry]
//
//    @State var activePrompt: Prompt = ModelData.prompts[0]
//
//
//    var body: some View{
//        HStack {
//            VStack(alignment: .leading, spacing: 8) {
//                Text(item.title)
//                    .font(.custom("DK Cool Crayon", size: 18))
//                    .multilineTextAlignment(.leading)
//                Text(item.mood.rawValue + " - " + item.category.rawValue)
//                    .font(.system(size: 10))
//                Text("18 Oct 2021")
//                    .font(.system(size: 10))
//            }
//            Image("Squid Guard A")
//                .resizable()
//                .frame(width: 50, height: 80)
//                .padding(.trailing, 30)
//        }
//        .padding()
//        LazyVStack{
//            ForEach(journalEntry, id:\.self){item in
//                NavigationLink(destination: CanvasView()) {
//                    HStack{
//                        VStack(alignment: .leading){
//                            Text(item.title)
//                                .font(.custom("DK Cool Crayon", size: 18))
//                                .multilineTextAlignment(.leading)
//                            Spacer()
//                            HStack{
//                                Text(item.mood.rawValue + " - " + item.category.rawValue)
//                            }.font(.system(size: 10))
//                            Text("18 Oct 2021")
//                                .font(.system(size: 10))
//                        }
//
//                    }.frame(width:300)
//                }
//
//            }
//            .padding(.horizontal, 10)
//            .padding(.vertical, 10)
//            .foregroundColor(Color.black)
//            .frame(height: 120)
//            .background(Color.white)
//            .cornerRadius(20)
//            .clipped()
//            .shadow(color: .gray, radius: 5, x: 0, y: 2)
//        }
//    }
//}


