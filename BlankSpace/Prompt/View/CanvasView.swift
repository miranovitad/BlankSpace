//
//  CanvasView.swift
//  BlankSpace
//
//  Created by Mira Novita Dewi Ni Putu on 13/10/21.
//

import SwiftUI
import HalfASheet
import Introspect

struct CanvasView: View {
    
    //from CanvasView to JournalList
    @State var title: String = ""
    @State var titleWidth: CGFloat = 150
    @State var titleHeight: CGFloat = 0
    @State var content: String = ""
    @State var placeholder: String = "Type here ..."
    @State private var height: CGFloat = .zero
    @State var titleStory:String = ""
    @State var isStickerModalPresented = false
    @State var activeStickers = [StickerStruct]()
    @State var stickerArray: [StoryStickerModel] = []
    @State var stickerCount: Int = 0
//    @Binding var story: StoryModel
    @EnvironmentObject var story: StoryModel
    @ObservedObject var stickerViewModel: StickerShopViewModel = StickerShopViewModel()
    @State var closeButton = false
    @State var edittedJournalList = false
    
    //from JournalList to CanvasDetail
    /// Jalur clickedJournal untuk membedakan diambil dari JournalListView atau dari RandomQuestion
    @Binding var clickedJournal: Bool
    /// Jalur editJournal untuk memberi kondisi ketika bisa edit CanvasView dari JournalListView dan dari RandomQuestion (namun dari JournalListView ada 2 Kondisi Edit dan Save)
    @Binding var editJournal: Bool
    
    //from RandomQuestion to CanvasDetail then back to JournalListView
    ///trigger isActive untuk close CanvasView
    @Binding var backToJournalListView: Bool
    ///trigger EncouragementMessage ketika DoneButton di klik di CanvasView
    @Binding var showEncouragementFinal: Bool
    ///trigger doneButton di CanvasView (untuk EdittedJournalMessage) *tapi belum bisa muncul entah kenapa*
    @Binding var doneButtontoJournalListView: Bool
    
    //Untuk trigger hide Keyboard ketika klik AddSticker
    @State var keyboardIsShowing: Bool = false
    
    
    let uuid = UUID().uuidString
    let buttonSize: CGFloat = 30
    let count = 1...10
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    
    var body: some View {
        ZStack {
            KeyboardView{
                VStack (alignment: .leading){
                    CustomNavBar(left: {
                        CloseButton(closeButtonPrompt: $closeButton, isEditting: $clickedJournal)
                            .disabled(editJournal == false)
                    }, center: {
                        VStack {
                            Text("Journal Entry")
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                                .foregroundColor(Color("DarkGreySlider"))
                            Text(Formatter.dateFormating().uppercased())
                                .font(.system(size: 15))
                                .foregroundColor(Color("DarkGreySlider"))
                        }
                    }, right: {
                        if clickedJournal == true{
                            if editJournal == true{
                                Button(action: {
                                    self.editJournal = false
                                }) {
                                    Text("Edit")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("BGColor"))
                                        .font(.system(size: 17))
                                }
                            }
                            else if editJournal == false{
                                Button(action: {
                                    self.doneButtontoJournalListView.toggle()
                                    self.editJournal = true
                                    self.clickedJournal = false
                                    self.backToJournalListView = false
                                    let managerUpdater = StoryManager()
                                    for sticker in activeStickers {
                                        stickerArray.append(StoryStickerModel(_idStorySticker: sticker.id, _x: 0, _y: 0))
                                    }
                                    let storyDataUpdater = StoryModel(_idStory: story.idStory, _date: story.date, _mood: story.mood, _aspect: story.aspect, _title: title, _content: content, _stickers: stickerArray)
                                    print("asd",content)
                                    let result = managerUpdater.update(record: storyDataUpdater)
                                    if(result == true) {
                                        debugPrint("record edited successfully")
                    
                                    } else {
                                        debugPrint("Create failed")
                                    }
                                }) {
                                    Text("Done")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("BGColor"))
                                        .font(.system(size: 17))
                                }
                            }
                        }
                        else if clickedJournal == false{
                            if editJournal == true{
//                                NavigationLink(destination: JournalListView(showEncouragement: false)){
                                Button(action: {
//                                    presentationMode.wrappedValue.dismiss()
                                    self.editJournal = true
                                    self.clickedJournal = false
                                    self.backToJournalListView = false
                                    self.showEncouragementFinal.toggle()
                                    print(activeStickers)
                                    story.title = title
                                    for sticker in activeStickers {
                                        stickerArray.append(StoryStickerModel(_idStorySticker: sticker.id, _x: 0, _y: 0))
                                    }
                                    let manager = StoryManager()
                                    let storyData = StoryModel(_idStory: UUID(), _date: Date(), _mood: story.mood, _aspect: story.aspect, _title: story.title, _content: content, _stickers: stickerArray)
                                    let result = manager.createStory(record: storyData)
                                    
                                    if(result == true) {
                                        
                                        let managerPoint = UserPointManager()

                                        let userPointData = UserPointModel(_idTrans: UUID(), _amount: Int32(25), _category: "+", _currentPoint: (stickerViewModel.getCurrentPoint()+Int32(25)), _date: Date(), _note: "Journal Entry")
                                        let result = managerPoint.createUserPoint(record: userPointData)

                                        if(result == true) {
                                            debugPrint("add point success")
                                        } else {
                                            debugPrint("add point failed")
                                        }
                                        
                                    } else {
                                        debugPrint("Create failed")
                                    }
                                        
                                }, label: {
                                    Text("Done")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("BGColor"))
                                        .font(.system(size: 17))
                                })
//                                    .introspectTabBarController {
//                                    (UITabBarController) in UITabBarController.tabBar.isHidden = false
//                                }
//                                }
                            }
                        }
                        
                    })
                    
                    ExpandingTextView(text: $title, maxHeight: 100, fontnya: UIFont(name: "DK Cool Crayon", size: 15) ?? .systemFont(ofSize: 15))
                        .lineSpacing(4)
                        .padding([.horizontal], 10)
                        .padding(.top, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 1)
                        ).padding(.top, 10)
                        .disabled(clickedJournal == true && editJournal == true)
                        .onAppear {
                            title = "Halooo"
                        }
                    
                    ZStack {
                        if self.content.isEmpty {
                            TextEditor(text:$placeholder)
                                .font(.custom("DK Cool Crayon", size: 15))
                                .foregroundColor(.gray)
                                .disabled(true)
                        }
                        TextEditor(text: $content)
                            .opacity(self.content.isEmpty ? 0.25 : 1)
                            .font(.custom("DK Cool Crayon", size: 15))
                            .frame(alignment: .topLeading)
                            .lineSpacing(7)
                            .onAppear{
                                content = story.content
                                title = story.title
                                print("title", title)
                            }
                    }.disabled(clickedJournal == true && editJournal == true )
                    .padding(.top, 5)
                    
                    
                    GeometryReader { geometry in
                        ScrollView(.horizontal) {
                            HStack (alignment: .center) {
                                if !activeStickers.isEmpty {
                                    ForEach(0...activeStickers.count-1, id: \.self) { i in
                                        ActiveStickerView(sticker: activeStickers[i], idx: i, activeStickers: $activeStickers, stickerCount: $stickerCount)
                                    }
                                }
                                if (stickerCount < 2) {
                                    Button(action: {
                                        isStickerModalPresented = true
                                            hide_keyboard()
                                        self.keyboardIsShowing = false
                                    }) {
                                        Image("btn_addSticker")
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    .disabled(clickedJournal == true && editJournal == true )
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .cornerRadius(80)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .cornerRadius(80)
                                }
                            }
                            .frame(minWidth: geometry.size.width)
                            .onChange(of: activeStickers, perform: { x in
                                stickerCount = activeStickers.count
                            })
                        }
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }.padding(.bottom, 70)
                }.padding(.all, 20)
            } toolBar: {
                HStack {
                    Spacer()
                    Button(action: {
                        hide_keyboard()
                        self.keyboardIsShowing = true
                    }, label: {
                        Text("Done")
                    })
                }
                .padding()
                .background(Color.white)
            }
            HalfASheet(isPresented: $isStickerModalPresented, title: "Stickers") {
                StickerPickerCollectionView(viewModel: StickerShopViewModel(), activeStickers: $activeStickers, modalStatus: $isStickerModalPresented)
            }
            .height(.proportional(0.5))
            .contentInsets(EdgeInsets(top: 50, leading: 10, bottom: 0, trailing: 10))
            .onAppear{
                title = story.title
                activeStickers = getStickerId(dataSticker: story.stickers ?? [])
                stickerCount = activeStickers.count
                titleWidth = title.widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold))
                titleHeight = title.heightOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold)) + 13
            }
            if closeButton == true{
                ZStack{
                    Rectangle()
                        .fill(Color.appColorGrey)
                        .opacity(0.5)
                        .ignoresSafeArea()
                    ClosePrompt(closeButton: $closeButton, closeButtonClicked: $backToJournalListView)
                }
            }
        }.navigationBarHidden(true)
            .introspectTabBarController {
                (UITabBarController) in UITabBarController.tabBar.isHidden = true
            }.hideNavigationBar()
    }
}

func getStickerId(dataSticker: [StoryStickerModel?]) -> [StickerStruct]{
    
    let stickerJson = ModelData.stickers
    var stickerArrary: [StickerStruct] = []
    
    for item in dataSticker {
        for sticker in stickerJson {
            if item?.idStorySticker == sticker.id {
                stickerArrary.append(StickerStruct(id: sticker.id, name: sticker.name, fileName: sticker.fileName, url: sticker.url, price: sticker.price, keyword: sticker.keyword, category: sticker.category))
            }
        }
    }
    
    if stickerArrary.isEmpty{
        return []
    }
    
    return stickerArrary
}
func hide_keyboard()
{
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

struct ActiveStickerView: View{
    let sticker: StickerStruct
    let idx: Int
    @Binding var activeStickers: [StickerStruct]
    @Binding var stickerCount: Int
    
    var body: some View{
        HStack {
            ZStack {
                Image("\(sticker.fileName)")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 150, maxHeight: 150)
                VStack{
                    HStack {
                        Spacer()
                        Button(action: {
                            deleteAtIdx(idx: idx)
                        }) {
                            Image(systemName: "xmark")
                        }
                        .font(Font.system(size: 13, weight: .bold))
                        .frame(width: 25, height: 25, alignment: .center)
                        .background(Color("BackButtonGrey"))
                        .foregroundColor(Color.white)
                        .cornerRadius(100)
                    }
                    Spacer()
                }.frame(width: 125, height: 100)
            }
        }
    }
    
    func deleteSticker(sticker: StickerStruct) {
        activeStickers.removeAll() {
            $0.id == sticker.id
        }
    }
    
    func deleteAtIdx(idx: Int) {
        activeStickers.remove(at: idx)
    }
}

