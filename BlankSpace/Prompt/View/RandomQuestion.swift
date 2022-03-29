//
//  Prompt5Frontend.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 05/10/21.
//

import SwiftUI
import Introspect

struct RandomQuestion: View {
    
    @ObservedObject var viewModel: RandomizePromptViewModel
    @EnvironmentObject var story: StoryModel
    @StateObject var activePrompt = CurrentPrompt()
    @State var counter = 0
    @State var loopPrompt = [Prompt]()
    @State var allPrompt = [String]()
    @State var closeButton = false
    @Binding var rootThirdIsActive: Bool
    @Binding var showEncouragement3: Bool
    @Binding var doneButton3: Bool
    @State var introView: Bool = true
    @State var randomPromptInfo: String = UserDefaults.standard.string(forKey: "randomPromptInfo") ?? ""
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    
    let myColor: UIColor = .random
    var colors: [Color] = [.yellow, .purple, .green]
    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(viewModel.contextualizedPrompt.count - 1 - id) * 1
        return geometry.size.width - offset
    }
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(viewModel.contextualizedPrompt.count - 1 - id) * 0
    }
    
    var body: some View {
        ZStack{
            ZStack{
                VStack{
                    GeometryReader { geometry in
                        VStack {
                            CustomNavBar (
                                left: {
                                    CloseButton(closeButtonPrompt: $closeButton, isEditting: .constant(false))
                                        .disabled(closeButton)
                                }, center: {
                                    VStack{
                                        Text("Journal Entry")
                                            .fontWeight(.bold)
                                            .font(.system(size: 15))
                                            .foregroundColor(Color("DarkGreySlider"))
                                        Text(Formatter.dateFormating().uppercased())
                                            .font(.system(size: 15))
                                            .foregroundColor(Color("DarkGreySlider"))
                                    }
                                }, right: {
                                    Text("")
                                })
                        }.padding(.all, 20)
                            .onAppear{
                                activePrompt.loopCount = viewModel.contextualizedPrompt.count
                                activePrompt.currentPrompt = activePrompt.allPrompt[activePrompt.count]
                            }
                        
                        HStack{
                            Spacer()
                            Image("backgroundCard")
                                .resizable()
                                .frame(maxWidth: 420, minHeight: 400, maxHeight: 700, alignment: .center)
                                .padding(.top, 75)
                                .scaledToFit()
                            Spacer()
                        }
                        ForEach(viewModel.contextualizedPrompt, id: \.self) { prom in
                            questionCard(myColor: .random, prompt: prom, onRemove: { removedCard in
                                
                                self.viewModel.contextualizedPrompt.removeAll() {
                                    $0.id == removedCard.id
                                }
                                let newCard = Prompt(id: "\(counter)", text: removedCard.text, aspect: removedCard.aspect)
                                loopPrompt.insert(newCard, at: 0)
                                if viewModel.contextualizedPrompt.count <= 1 {
                                    self.viewModel.contextualizedPrompt = loopPrompt
                                    let loopPromptString = loopPrompt.map { item in
                                        item.text
                                    }
                                    //                        activePrompt.allPrompt = loopPromptString
                                    allPrompt = loopPromptString
                                    loopPrompt = []
                                    counter = loopPromptString.count
                                }
                                //                    changeCurrentPrompt()
                                changeActivePrompt()
                                
                            }).environmentObject(activePrompt)
                                .animation(.spring())
                                .frame(width: self.getCardWidth(geometry, id: Int(prom.id)!), height: 300)
                                .offset(x: 0, y: self.getCardOffset(geometry, id: Int(prom.id)!))
                                .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                                .onAppear {
                                    activePrompt.allPrompt.append(prom.text)
                                    allPrompt = viewModel.contextualizedPrompt.map { item in
                                        item.text
                                    }
                                    counter = allPrompt.count - 1
                                }
                        }
                        
                    }.navigationBarHidden(true)
                    
                    VStack {
                        NavigationLink(destination: CanvasView(clickedJournal: .constant(false), editJournal: .constant(true), backToJournalListView: $rootThirdIsActive, showEncouragementFinal: $showEncouragement3, doneButtontoJournalListView: $doneButton3).environmentObject(StoryModel(_idStory: UUID(), _date: Date(), _mood: story.mood, _aspect: .study, _title: "", _content: ""))){
                            Text("Skip the Question")
                                .fontWeight(.bold)
                                .font(.system(size: 17))
                                .foregroundColor(Color.appColorGrey)
                        }.padding(.top, 5)
                            .padding(.bottom, 9)
                        HStack{
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                            }.frame(width: 25, height: 25, alignment: .center)
                                .font(Font.system(size: 23, weight: .bold))
                                .foregroundColor(Color.white)
                                .padding()
                                .background(Color.appColorGrey)
                                .cornerRadius(80)
                                .navigationBarHidden(true)

                            Spacer()
                            
                            NavigationLink(destination: CanvasView(clickedJournal: .constant(false), editJournal: .constant(true), backToJournalListView: $rootThirdIsActive, showEncouragementFinal: $showEncouragement3, doneButtontoJournalListView: $doneButton3).environmentObject(StoryModel(_idStory: UUID(), _date: Date(), _mood: story.mood, _aspect: .study, _title: activePrompt.currentPrompt, _content: ""))) {
                                Image(systemName: "chevron.right")
                            }
                            .frame(width: 25, height: 25, alignment: .center)
                            .font(Font.system(size: 23, weight: .bold))
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color("BGColor"))
                            .cornerRadius(80)
                            .navigationBarHidden(true)
                        }
                    }.padding(.all, 20)
                }
                .blur(radius: closeButton ? 5 : 0)
                if closeButton == true{
                    ClosePrompt(closeButton: $closeButton, closeButtonClicked: $rootThirdIsActive)
                }
            }.introspectTabBarController {
                (UITabBarController) in UITabBarController.tabBar.isHidden = true
            }.hideNavigationBar()
            
            if(randomPromptInfo == ""){
                if(introView==true) {
                    ZStack {
                        Rectangle()
                            .fill(Color.appColorGrey)
                            .opacity(0.8)
                            .ignoresSafeArea()
                        VStack {
                            Image("swipe icon")
                                .resizable()
                                .frame(width: 190, height: 70, alignment: .center)
                                .padding(.top, 75)
                                .scaledToFit()
                            Text("Swipe left or right to see other questions")
                                .font(.custom("DK Cool Crayon", size: 18))
                                .multilineTextAlignment(.center)
                                .lineSpacing(2)
                                .padding(.top, 20)
                                .padding(.horizontal, 20)
                                .foregroundColor(Color.white)
                        }
                    }.onTapGesture {
                        introView = false
                        UserDefaults.standard.set("Set", forKey: "randomPromptInfo")
                    }
                }
            }
            
        } //ZStack
    }
    
    func changeActivePrompt() {
        counter -= 1
        activePrompt.currentPrompt = allPrompt[counter]
    }
    
    func changeCurrentPrompt() {
        activePrompt.count = Int(activePrompt.count + 1)
        if activePrompt.count < activePrompt.allPrompt.count {
            activePrompt.currentPrompt = activePrompt.allPrompt[activePrompt.count]
        }
        print(activePrompt.allPrompt)
        print(activePrompt.currentPrompt)
        return
    }
}

struct questionCard: View {
    
    @EnvironmentObject var activePrompt: CurrentPrompt
    @State private var translation: CGSize = .zero
    let myColor: UIColor
    private var prompt: Prompt
    private var onRemove: (_ prompt: Prompt) -> Void
    private var thresholdPercentage: CGFloat = 0.5
    init(myColor: UIColor, prompt: Prompt, onRemove: @escaping (_ prompt: Prompt) -> Void) {
        self.prompt = prompt
        self.onRemove = onRemove
        self.myColor = myColor
    }
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        return gesture.translation.width / geometry.size.width
    }
    var colors: [Color] = [.appColorBlue, .appColorGreen, .appColorPrimary, .appColorRed]
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Text("Question of the day")
                    .fontWeight(.bold)
                    .font(.system(size: 17))
                    .foregroundColor(Color.white)
                    .overlay(
                        Rectangle().frame(height: 2).offset(y: 4)
                        , alignment: .bottom)
                    .padding(.top, 20)
                Spacer()
                Text(prompt.text)
                    .font(.custom("DK Cool Crayon", size: 18))
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)
                    .padding([.horizontal], 20)
                Spacer()
                Image("logo_small")
                    .padding()
            }
            .frame(width: geometry.size.width * 0.75, height: geometry.size.height)
            .background(colors[Int(prompt.id)! % colors.count])
            .foregroundColor(Color.white)
            .cornerRadius(20)
            .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                    }.onEnded { value in
                        if abs(self.getGesturePercentage(geometry, from: value)) >= self.thresholdPercentage {
                            print("Hapus Kartu")
                            if(activePrompt.loopCount == 0){
                                print("udah 0 nih")
                            }
                            self.onRemove(self.prompt)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
            .onAppear{
                activePrompt.currentPrompt = prompt.text
            }
        }.frame(maxWidth: 350, minHeight: 500, maxHeight: 750)
            .padding(.top, 85)
    }
}

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}
