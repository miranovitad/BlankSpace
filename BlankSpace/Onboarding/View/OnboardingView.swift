//
//  PageTabView.swift
//  BlankSpace
//
//  Created by Ni Putu Mira Novita Dewi on 09/11/21.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var text: String = ""
    @State private var buttonTitle: String = ""
    @State var selectedTab: Int = 0
    @State private var name: String = ""
    @State var buttonStart: Bool = false
    @State var showMainView: Bool = false
    let showEncouragement: Bool = false
    
    var body: some View {
        NavigationView {
            if showMainView {
                MainView(showEncouragement: showEncouragement)
            } else {
                VStack {
                    TabView(selection: $selectedTab){
                        ForEach(tabs.indices, id: \.self) { index in
                            OnboardingItemView(index: index).tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    
                    if (selectedTab < 2) {
                        NavigationLink(destination: WelcomeScreenView(name: $name, buttonStart: .constant(true))) {
                            Text("Skip")
                                .font(Font.system(size: 16, weight: .bold))
                                .foregroundColor(Color.appColorGrey)
                                .padding(.vertical, 30)
                        }
                    } else {
                        NavigationLink(destination: WelcomeScreenView(name: $name, buttonStart: .constant(true))) {
                            ZStack{
                                Image("PromptButton")
                                    .resizable()
                                    .frame(width: 150, height: 50, alignment: .center)
                                Text("Get Started")
                                    .font(.custom("DK Cool Crayon", size: 18))
                                    .foregroundColor(Color.white)
                            }.padding(.vertical, 30)
                        }
                    }
                }
                .onAppear {
                    setupAppearance()
                }
            }
        }
    }
}

func setupAppearance() {
    UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.appColorPrimary)
    UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
}

struct PageTabView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

