//
//  AutoSizingTextField.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 12/11/21.
// UNUSED

import SwiftUI

struct Cobaan: View {
    @State var txt = ""
    @State var containerHeight: CGFloat = 0
    @State var containerWidth: CGFloat = 50
    var body: some View {
        VStack(alignment: .leading){ 
            Text("Coba autosizing textfield")
            AutoSizingTextField(hint: "Enter text", font: UIFont(name: "DK Cool Crayon", size: 15) ?? UIFont(), text: $txt, containerHeight: $containerHeight, minContainerWidth: $containerWidth)
                .frame(width: containerWidth, height: containerHeight, alignment: .topLeading)
                .lineSpacing(4)
                .padding([.horizontal], 10)
                .padding(.top, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                ).padding(.top, 10)
                .onChange(of: txt) { x in
                    if (containerWidth >= UIScreen.main.bounds.width - 67) {
                        self.containerWidth = UIScreen.main.bounds.width - 67
                    } else {
                        self.containerWidth = x.widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold)) + 13
                    }
                }
                
            Spacer()
        }.onAppear {
            txt = "asdfadsfadfadfad"
            print("txt",txt)
        }
    }
}

struct AutoSizingTextField: UIViewRepresentable {
    
    let hint: String
    let font: UIFont
    @Binding var text: String
    @Binding var containerHeight: CGFloat
    @Binding var minContainerWidth: CGFloat
    
    func makeCoordinator() -> Coordinator {
        return AutoSizingTextField.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        textView.text = hint
//        textView.textColor = .gray
        textView.font = font
        
        textView.delegate = context.coordinator
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            if containerHeight == 0 {
                containerHeight = uiView.contentSize.height
            }
            if minContainerWidth == 0 {
                minContainerWidth = 100
            }
            
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: AutoSizingTextField
        
        init(parent: AutoSizingTextField) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            // if textbox edited, remove hint
            if textView.text == parent.hint {
                textView.text = ""
                textView.textColor = UIColor(Color.primary)
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.containerHeight = textView.contentSize.height
            parent.minContainerWidth = textView.contentSize.width
            print(textView.contentSize.width)
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.hint
                textView.textColor = .gray
            }
        }
    }
}

struct AutoSizingTextField_Previews: PreviewProvider {
    static var previews: some View {
        Cobaan()
    }
}
