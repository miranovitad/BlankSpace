//
//  TabDetailView.swift
//  BlankSpace
//
//  Created by Ni Putu Mira Novita Dewi on 09/11/21.
//

import SwiftUI

struct OnboardingItemView: View {
    
    let index: Int
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            Image(tabs[index].image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
            
            Text(tabs[index].text)
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
                .font(.custom("DK Cool Crayon", size: 16))
                .lineSpacing(3)
                .padding(.top, 20)
        }
    }
}

//struct TabDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingItemView(index: 0)
//    }
//}

