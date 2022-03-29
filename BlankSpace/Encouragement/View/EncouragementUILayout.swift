//
//  Encouragement.swift
//  BlankSpace
//
//  Created by Refa Satya Pramudhito on 04/11/21.
//

import SwiftUI

struct EncouragementUILayout: View{
    @State var countingStreak = 0
    @State var encouragementAlert = false
    @Binding var toggleEncouragement: Bool
    var body: some View{
        ZStack{
            if countingStreak<=3 && encouragementAlert == false{
                Rectangle()
                    .fill(Color.gray)
                    .opacity(0.5)
                    .ignoresSafeArea()
                EncouragementMessages(streakCount: $countingStreak, encouragementMessages: $encouragementAlert)
                EncouragementOffsetImage().offset(x: 0, y: -150)
            }
            else if countingStreak == 4 && encouragementAlert == false{
                Rectangle()
                    .fill(Color.gray)
                    .opacity(0.5)
                    .ignoresSafeArea()
                EncouragementMessages(streakCount: $countingStreak, encouragementMessages: $encouragementAlert)
                EncouragementOffsetImage().offset(x: 0, y: -270)
            }
        }.navigationBarHidden(true)
    }
}
struct EncouragementUILayout_Previews: PreviewProvider {
    static var previews: some View {
        EncouragementUILayout(toggleEncouragement: .constant(false))
    }
}
