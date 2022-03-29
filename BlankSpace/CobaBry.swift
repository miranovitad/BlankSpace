//
//  CobaBry.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 11/10/21.
//

import SwiftUI
import HalfASheet

struct CobaBry: View {
    
    @State var txt = ""
    let onCommit: (String) -> Void = { str in
        print(str)
    }
    let content = ""
    
    var body: some View {
        VStack {
            DismissableTextField(text: $txt, onCommit: onCommit)
            .opacity(self.content.isEmpty ? 0.25 : 1)
            .font(.custom("DK Cool Crayon", size: 15))
            .frame(height: UIScreen.main.bounds.height - 340, alignment: .topLeading)
            .lineSpacing(7)
        }
    }
}

struct KeyboardToolBar: View {
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    var body: some View {
        
        NavigationView {
            KeyboardView {
                ScrollView {
                    Spacer()
                    Text("Welcome")
                        .font(.largeTitle)
                    VStack {
                        TextField("Name", text: $name)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary, lineWidth: 1)
                            .frame(height: 50))
                            .keyboardType(.namePhonePad)
                        
                        TextField("Phone Number", text: $phoneNumber)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary, lineWidth: 1)
                            .frame(height: 50))
                            .keyboardType(.numberPad)
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Continue")
                        })
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary, lineWidth: 1))
                        
                        
                            
                    }.padding()
                }
            } toolBar: {
                HStack {
                    Spacer()
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Text("Done")
                    })
                }
                .padding()
                .background(Color.white)
            }
            .navigationBarTitle("Sign Up", displayMode: .inline)
        }
    }
}

struct keyboardToolBar_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardToolBar()
    }
}

//struct CobaBry_Previews: PreviewProvider {
//    static var previews: some View {
//        CobaBry()
//    }
//}
