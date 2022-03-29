//
//  CloseButton.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 08/11/21.
//

import SwiftUI

struct CloseButton: View {
    @Binding var closeButtonPrompt: Bool
    @Binding var isEditting: Bool
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack{
            Button(action: {
                self.closeButtonPrompt.toggle()
                if isEditting == true{
                presentationMode.wrappedValue.dismiss()
                }
            }) {
                Image(systemName: "xmark")
            }
            .font(Font.system(size: 13, weight: .bold))
            .frame(width: 25, height: 25, alignment: .center)
            .background(Color("BGColor"))
            .foregroundColor(Color.white)
            .cornerRadius(100)
        }
    }
}

