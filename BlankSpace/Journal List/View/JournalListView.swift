//
//  MainView1.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 22/10/21.
//

import SwiftUI
import HalfASheet
import Introspect

struct JournalListView: View{
    @State private var isEditing = false
    @State var isEmpty = false
    @StateObject var viewModel = JournalListViewModel()
    
    @State var sort: Bool = false
    @State private var textFieldId: String = UUID().uuidString
    
    //    let story: StoryModel
    @StateObject var activePrompt = CurrentPrompt()
    //from JournalList to CanvasDetail
    /// Jalur editJournal untuk memberi kondisi ketika bisa edit CanvasView dari JournalListView dan dari RandomQuestion (namun dari JournalListView ada 2 Kondisi Edit dan Save)
    @State var editJournal = true

    ///untuk trigger halaman CanvasView tanpa NavigationLink (Mainan Binding di false in aja biar langsung bisa balik ke JournalListView)
    @State var isActive: Bool = false
    @EnvironmentObject var story: StoryModel
    
    ///untuk trigger EncouragementMessage dari jalur RandomQuestion ke CanvasView
    @State var showEncouragement: Bool = false
    ///untuk trigger doneButton dari jalur RandomQuestion ke CanvasView tanpa ada tombol editButton di CanvasView
    @State var doneButtonCanvas: Bool = false
    ///trigger closeButton di setiap Prompt
    @State var closeButtonClicked: Bool = false
    
    @State var closeButton = false
    
    var isTabBarHidden = false
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack{
                    HStack{
                        SearchBar(searchText: $viewModel.searchText, textFieldId: $textFieldId)
                        Button(action: {
                            sort.toggle()
                            viewModel.filteredEntries = viewModel.sortStory(orderDes: sort, filteredEntries: viewModel.filteredEntries)
                            textFieldId = UUID().uuidString
                        })
                        {
                            Image(systemName: "arrow.up.arrow.down").resizable()
                        }.foregroundColor(Color("BGColor"))
                            .frame(width: 23, height: 20, alignment: .center)
                            .padding(.leading, 10)
                        
                        Button(action: {
                            viewModel.isPresented = true
                            textFieldId = UUID().uuidString
                        })
                        {
                            Image(systemName: "slider.horizontal.3").resizable()
                        }
                        .foregroundColor(Color("BGColor"))
                        .frame(width: 23, height: 20, alignment: .center)
                        .padding(.leading, 10)
                        
                    }.padding()
                        .onAppear{
                            viewModel.getSavedStory()
                        }
                    NavigationLink(destination: MoodView(rootIsActive: $isActive, showEncouragement1: $showEncouragement, doneButton1: $doneButtonCanvas), isActive: $isActive) {
                        Text("+ Add New Entry")
                            .frame(minWidth: 0, maxWidth: .infinity,maxHeight: 38, alignment: .center)
                            .font(.custom("DK Cool Crayon", size: 16))
                            .foregroundColor(Color.white)
                            .background(Color("BGColor"))
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                    if(viewModel.filteredEntries.count == 0){
                        JournalListViewEmpty(searchCount: viewModel.searchText.count, filter: viewModel.filter)
                    }
                    else{
                        ScrollView{
                            LazyVStack{
                                ForEach(viewModel.filteredEntries) { item in
                                    NavigationLink(destination: CanvasView(clickedJournal: .constant(true), editJournal: $editJournal, backToJournalListView: $closeButtonClicked, showEncouragementFinal: $showEncouragement, doneButtontoJournalListView: $doneButtonCanvas).environmentObject(item)){

                                        ListView(title: item.title, mood: item.mood, aspect: item.aspect, date: item.date, sticker: item.stickers ?? [])
                                        
//                                            .onChange(of: viewModel.filteredEntries, perform: { x in
//                                                viewModel.filteredEntries = viewModel.filteredEntries
//                                            })
                                            .addButtonActions(leadingButtons: [], trailingButton:  [.delete], onClick: { button in
                                                if button == .delete {
                                                    viewModel.deleteStory(data: item)
                                                }
                                            })
                                    }
                                }
                            }.padding(.top, 10)
                            
                        }
                        
                    }
                    Spacer()
                }
                HalfASheet(isPresented: $viewModel.isPresented) {
                    FilterModalView(viewModel: FilterModalViewModel(parentViewModel: viewModel))
                }
                .height(.proportional(0.6))
                .contentInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .closeButtonColor(.clear)
                .hideCloseButton
                
                if showEncouragement == true{
                    EncouragementUILayout(toggleEncouragement: $showEncouragement)
                }
                if doneButtonCanvas == true{
                    ZStack{
                        Rectangle()
                            .fill(Color.gray)
                            .opacity(0.5)
                            .ignoresSafeArea()
                    EdittedJournal(doneButton: $doneButtonCanvas)
                    }
                }
            }.navigationBarHidden(true)
        }.introspectTabBarController {
            (UITabBarController) in UITabBarController.tabBar.isHidden = isTabBarHidden
        }
        
        .navigationBarHidden(true)
    }
}

struct JournalListView_Previews: PreviewProvider {
    static var previews: some View {
        JournalListView(showEncouragement: false)
    }
}
