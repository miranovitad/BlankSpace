//
//  WelcomeScreenView.swift
//  BlankSpace
//
//  Created by Ni Putu Mira Novita Dewi on 10/11/21.
//

import SwiftUI

struct WelcomeScreenView: View {
    
    @Binding var name: String
    @Binding var buttonStart: Bool
    @State var showMainView: Bool = false
    let showEncouragement: Bool = false
    
    var body: some View {
        if showMainView {
            MainView(showEncouragement: showEncouragement).navigationBarHidden(true)
        } else {
            VStack {
                Text("Welcome to Blank Space")
                    .multilineTextAlignment(.center)
                    .font(.custom("DK Cool Crayon", size: 16))
                Image("onboarding-page4")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                Text("Before we start, let me know your name")
                    .multilineTextAlignment(.center)
                    .font(.custom("DK Cool Crayon", size: 15))
                    .padding(.horizontal, 25)
                TextField("Nickname", text: $name)
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30).stroke(Color.appColorDarkGrey, lineWidth: 2)
                    )
                    .padding(.horizontal, 50)
                    .padding(.top, 30)
                    .font(.custom("DK Cool Crayon", size: 14))
                    .multilineTextAlignment(.center)
                if (buttonStart == true) {
                    Button(action: {
                        UserDefaults.standard.set(self.name, forKey: "Name")
                        showMainView = true
                    }) {
                        ZStack{
                            Image("PromptButton")
                                .resizable()
                                .frame(width: 150, height: 50, alignment: .center)
                            Text("Start")
                                .font(.custom("DK Cool Crayon", size: 18))
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding()
                    .zIndex(0.1)
                }
            }
            .onAppear {
                name = UserDefaults.standard.string(forKey: "Name") ?? ""
            }
            .navigationBarHidden(true)
        }
        
    }
    
    //struct WelcomeScreenView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        WelcomeScreenView()
    //    }
    //}
}
