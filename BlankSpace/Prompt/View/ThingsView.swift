//
//  Prompt2Frontend.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 05/10/21.
//

import SwiftUI
import Introspect

struct Activity: Identifiable  {
    var id: Int
    var title: String
    let category: PromptCategory
    var image: String
}

struct ThingsView: View {
    
    @EnvironmentObject var story: StoryModel
    @State var selectedActivity : Set<PromptCategory> = [.study]
    @State private var buttonTapped = false
    @State var selected = 0
    @State var select = false
    @State var imageSelected: String = "cat_study"
    @State var closeButton = false
    var colors: [Color] = [.yellow, .purple, .green]
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @Binding var rootSecondIsActive: Bool
    @Binding var showEncouragement2: Bool
    @Binding var doneButton2: Bool
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    
    let Prompt1es:[Activity] = [
        Activity(id: 0, title: "Study", category: .study, image: "cat_study"),
        Activity(id: 1, title: "Work", category: .work, image: "cat_work"),
        Activity(id: 2, title: "Hobby", category: .hobby, image: "cat_hobby"),
        Activity(id: 3, title: "Health", category: .health, image: "cat_health"),
        Activity(id: 4, title: "Finance", category: .finance, image: "cat_finance"),
        Activity(id: 5, title: "Relationship", category: .relationship, image: "cat_relationship"),
        Activity(id: 6, title: "Family", category: .family, image: "cat_family"),
        Activity(id: 7, title: "Future", category: .future, image: "cat_future"),
        Activity(id: 8, title: "Friend", category: .friend, image: "cat_friends"),
        Activity(id: 9, title: "Others", category: .others, image: "cat_others")
    ]
    
    var body: some View {
        ZStack{
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
                
                Spacer()
                
                ScrollView {
                    Image(imageSelected)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 250, maxHeight: 230, alignment: .center)
                    Text("What is the thing that affect you?")
                        .font(.custom("DK Cool Crayon", size: 20))
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                    LazyVGrid(columns: gridItemLayout, spacing: 15){
                        ForEach(Prompt1es, id: \.id) { box in
                            BoxView(box: box, selectedBtnid: self.$selected, selectedActivity: $selectedActivity, imageSelected: $imageSelected)
                                .font(.custom("DK Cool Crayon", size: 14))
                        }
                    }.padding(.top, 10)
                    Spacer()
                }
                
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }.frame(width: 25, height: 25, alignment: .center)
                        .font(Font.system(size: 23, weight: .bold))
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color("BGColor"))
                        .cornerRadius(80)
                        .navigationBarHidden(true)
                    
                    
                    
                    
                    Spacer()
                    
                    NavigationLink(destination: RandomQuestion(viewModel: RandomizePromptViewModel.init(context: selectedActivity), rootThirdIsActive: $rootSecondIsActive, showEncouragement3: $showEncouragement2, doneButton3: $doneButton2).environmentObject(StoryModel.init(_idStory: UUID(), _date: Date(), _mood: story.mood, _aspect: story.aspect, _title: "", _content: ""))) {
                        Image(systemName: "chevron.right")
                    }.frame(width: 25, height: 25, alignment: .center)
                        .font(Font.system(size: 23, weight: .bold))
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color("BGColor"))
                        .cornerRadius(80)
                        .navigationBarHidden(true)
                }.padding(.horizontal, 10)
                
            }.padding(.all, 20)
                .blur(radius: closeButton ? 5 : 0)
            if closeButton == true{
                ClosePrompt(closeButton: $closeButton, closeButtonClicked: $rootSecondIsActive)
            }
        }.introspectTabBarController {
            (UITabBarController) in UITabBarController.tabBar.isHidden = true
        }.hideNavigationBar()
    }
}

struct BoxView: View {
    
    var box: Activity
    @Binding var selectedBtnid: Int
    @Binding var selectedActivity: Set<PromptCategory>
    @Binding var imageSelected: String
    @EnvironmentObject var story: StoryModel
    
    var body: some View {
        Button(action: {
            self.selectedBtnid = self.box.id
            story.aspect = self.box.category
            self.selectedActivity = [box.category]
            imageSelected = self.box.image
        }){
            ZStack{
                Image(self.selectedBtnid == self.box.id ? "PromptButton" : "PromptButton2")
                    .resizable()
                    .scaledToFit()
                Text(box.title)
                    .foregroundColor(.black)
            }
        }.frame(height: 45)
    }
    
}

//struct Prompt2Frontend_Previews: PreviewProvider {
//    static var previews: some View {
//        ThingsView().environmentObject(StoryModel(_idStory: UUID(), _date: Date(), _mood: .kindabad, _aspect: .study, _title: "", _content: ""))
//    }
//}
