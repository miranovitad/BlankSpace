//
//  StickerShopView.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 25/10/21.
//

import SwiftUI
import HalfASheet

struct StickerShopView: View{
    
    @State var pickerSelection = 1
    @ObservedObject var viewModel: StickerShopViewModel = StickerShopViewModel()
    @State var stickerBuyAlert = false
    @State private var textFieldId: String = UUID().uuidString
    @State private var coin:Int32 = 0
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("BGColor"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    Spacer()
                    Text("\(coin)")
                        .font(.custom("DK Cool Crayon", size: 18))
                        .foregroundColor(Color("BGColor"))
                    Image("Coin")
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                Picker(selection: $pickerSelection, label: Text("")) {
                    Text("Owned").tag(0)
                    Text("Shop").tag(1)
                }.pickerStyle(SegmentedPickerStyle()).foregroundColor(Color.orange)
                    .padding(.horizontal)
                    .disabled(stickerBuyAlert)
                VStack {
                    HStack{
                        SearchBar(searchText: $viewModel.searchText, textFieldId: $textFieldId)
                            .disabled(stickerBuyAlert)
                        Button(action: {
                            viewModel.isPresented.toggle()
                        })
                        {
                            Image(systemName: "slider.horizontal.3")
                        }
                        .foregroundColor(Color("BGColor"))
                        .disabled(stickerBuyAlert)
                        
                    }.padding()
                }.onTapGesture {
                    stickerBuyAlert = false
                }
                
                if pickerSelection == 0{
                    StickerOwnedListView(viewModel: viewModel, stickerAlertOwned: $stickerBuyAlert)
                }
                else {
                    StickerListView(viewModel: viewModel, stickerAlertBuy: $stickerBuyAlert, currentPoint: $coin)
                }
                Spacer()
            }
            HalfASheet(isPresented: $viewModel.isPresented) {
                FilterModalView(viewModel: FilterModalViewModel(parentViewModel: viewModel), filterType: .category)
            }
            .height(.proportional(0.4))
            .contentInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .closeButtonColor(.clear)
            .hideCloseButton
        }.hideNavigationBar()
            .onAppear {
                coin = viewModel.getCurrentPoint()
            }
    }
}

extension View {
    func hideNavigationBar() -> some View {
        self
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
}
