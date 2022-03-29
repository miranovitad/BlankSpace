//
//  ClosePrompt.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 09/11/21.
//

import SwiftUI

struct ClosePrompt: View {
    @Binding var closeButton: Bool
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Binding var closeButtonClicked: Bool
    var body: some View {
        VStack{
            Text("Are you sure you want to leave this page?")
                .font(.custom("DK Cool Crayon", size: 20))
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                self.closeButton = false
                print("test")
            }) {
                VStack{
                    ZStack{
                        Image("PromptButton")
                            .resizable()
                            .frame(width: 150, height: 50, alignment: .center)
                        Text("Cancel")
                            .font(.custom("DK Cool Crayon", size: 18))
                            .foregroundColor(Color.white)
                    }
                }
            }
            Button {
                self.closeButton = false
                self.closeButtonClicked = false
            } label: {
                ZStack{
                    Image("PromptButton3")
                        .resizable()
                        .frame(width: 180, height: 60, alignment: .center)
                    Text("Yes")
                        .font(.custom("DK Cool Crayon", size: 18))
                        .foregroundColor(Color.white)
                }
            }
        }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.4)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .navigationBarHidden(true)
//            .onDisappear {
//                self.closeButtonClicked = false
//            }
    }
}

//struct ClosePrompt_Previews: PreviewProvider {
//    static var previews: some View {
//        ClosePrompt(closeButton: .constant(true))
//    }
//}
