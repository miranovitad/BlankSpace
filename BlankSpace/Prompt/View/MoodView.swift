//
//  PromptFrontend.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 04/10/21.
//

import SwiftUI
import Introspect

struct MoodView: View {
    
    @State var sliderProgress: CGFloat = 0
    @State var sliderWidth: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    @State var maxWidth: CGFloat = 300
    @State var uiTabarController: UITabBarController?
    @State var closeButton = false
    @Binding var rootIsActive: Bool
    @Binding var showEncouragement1: Bool
    @Binding var doneButton1: Bool
    @State var name: String = UserDefaults.standard.string(forKey: "Name") ?? ""
    
    @StateObject var story = StoryModel(_idStory: UUID(), _date: Date(), _mood: .bad, _aspect: .study, _title: "", _content: "")
    
    var body: some View {
        ZStack{
        VStack{
            CustomNavBar(
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
            
            Spacer()
            
            Text("Hello "+name+", how's your day?")
                .font(.custom("DK Cool Crayon", size: 20))
                .multilineTextAlignment(.center)
            
            if (sliderWidth <= 60){
                Image("mood_bad")
                    .resizable()
                    .frame(width: 312, height: 334, alignment: .center)
                    .scaledToFit()
                Text("Bad")
                    .font(.custom("DK Cool Crayon", size: 20))
                    .onAppear{
                        story.mood = .bad
                    }
            } else if (sliderWidth <= 120) {
                Image("mood_kindaBad")
                    .resizable()
                    .frame(width: 312, height: 334, alignment: .center)
                    .scaledToFit()
                Text("Kinda Bad")
                    .font(.custom("DK Cool Crayon", size: 20))
                    .onAppear{
                        story.mood = .kindabad
                    }
            } else if (sliderWidth <= 180) {
                Image("mood_soso")
                    .resizable()
                    .frame(width: 312, height: 334, alignment: .center)
                    .scaledToFit()
                Text("So so")
                    .font(.custom("DK Cool Crayon", size: 20))
                    .onAppear{
                        story.mood = .soso
                    }
            } else if (sliderWidth <= 240) {
                Image("mood_kindaGood")
                    .resizable()
                    .frame(width: 312, height: 334, alignment: .center)
                    .scaledToFit()
                Text("Kinda Good")
                    .font(.custom("DK Cool Crayon", size: 20))
                    .onAppear{
                        story.mood = .kindagood
                    }
            } else {
                Image("mood_good")
                    .resizable()
                    .frame(width: 312, height: 334, alignment: .center)
                    .scaledToFit()
                Text("Good")
                    .font(.custom("DK Cool Crayon", size: 20))
                    .onAppear{
                        story.mood = .good
                    }
            }
            
            
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(Color("PromptUnselected")).opacity(0.8)
                    .frame(width: 300, height: 15, alignment: .center)
                    .cornerRadius(15)
                Rectangle()
                    .fill(Color("BGColor")).opacity(0.8)
                    .frame(width: sliderWidth, height: 15, alignment: .center)
                    .cornerRadius(15)
                Circle()
                    .foregroundColor(Color("DarkGreySlider"))
                    .offset(x: sliderWidth - 20, y: 0)
                    .frame(width: 35, height: 35, alignment: .center)
            }
            .gesture(DragGesture(minimumDistance: 0).onChanged({ (value) in let translation = value.translation
                sliderWidth = translation.width + lastDragValue
                sliderWidth = sliderWidth <= maxWidth ? sliderWidth : maxWidth
                sliderWidth = sliderWidth >= 0 ? sliderWidth : 0
                let progress = sliderWidth / maxWidth
                sliderProgress = progress <= 1.0 ? progress : 1
            }).onEnded({ (value) in
                sliderWidth = sliderWidth <= maxWidth ? sliderWidth : maxWidth
                sliderWidth = sliderWidth >= 0 ? sliderWidth : 0
                lastDragValue = sliderWidth
            }))
            .padding(.top, 20)
            
            Spacer()
            
            NavigationLink(destination: ThingsView(rootSecondIsActive: $rootIsActive, showEncouragement2: $showEncouragement1, doneButton2: $doneButton1).environmentObject(StoryModel(_idStory: UUID(), _date: Date(), _mood: story.mood, _aspect: .study, _title: "", _content: ""))) {
                Image(systemName: "chevron.right")
            }.frame(width: 25, height: 25, alignment: .center)
                .font(Font.system(size: 23, weight: .bold))
                .foregroundColor(Color.white)
                .padding()
                .background(Color("BGColor"))
                .cornerRadius(80)
            
        }.navigationBarHidden(true)
            .padding(.all, 20)
            .blur(radius: closeButton ? 5 : 0)
            if closeButton == true{
                ClosePrompt(closeButton: $closeButton, closeButtonClicked: $rootIsActive)
            }
        }.introspectTabBarController {
            (UITabBarController) in UITabBarController.tabBar.isHidden = true
        }.hideNavigationBar()
    }
}

//struct PromptFrontend_Previews: PreviewProvider {
//    static var previews: some View {
//        MoodView(rootIsActive: .constant(false), showEncouragement1: .constant(false), doneButton1: .constant(false))
//    }
//}

