//
//  ExpandingTextView.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 13/11/21.
//

import SwiftUI

struct WrappedTextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
    let textDidChange: (UITextView) -> Void
    let usingFont: UIFont
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.font = usingFont
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = self.text
        DispatchQueue.main.async {
            self.textDidChange(uiView)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, textDidChange: textDidChange)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        let textDidChange: (UITextView) -> Void
        
        init(text: Binding<String>, textDidChange: @escaping (UITextView) -> Void) {
            self._text = text
            self.textDidChange = textDidChange
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text = textView.text
            self.textDidChange(textView)
        }
    }
}


struct ExpandingTextView: View {
    @Binding var text: String
    let minHeight: CGFloat = 0
    let maxHeight: CGFloat
    @State private var textViewHeight: CGFloat = 0
    let fontnya: UIFont
    
    var body: some View {
        WrappedTextView(text: $text, textDidChange: self.textDidChange, usingFont: fontnya)
            .frame(height: textViewHeight >= maxHeight ? maxHeight : textViewHeight)
    }
    
    private func textDidChange(_ textView: UITextView) {
        self.textViewHeight = max(textView.contentSize.height, minHeight)
        
        print(textView.contentSize.width)
    }
}

struct CobaanLagi: View {
    @State var txt: String = "adsofiadjsfoijadfs"
    
    var body: some View {
        VStack {
            ExpandingTextView(text: $txt, maxHeight: 150, fontnya: UIFont(name: "DK Cool Crayon", size: 15) ?? .systemFont(ofSize: 15))
                .lineSpacing(4)
                .padding([.horizontal], 10)
                .padding(.top, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                ).padding(.top, 10)
                .onAppear {
                    txt = "haloooo"
                }
            Button("LALALA") {
                txt = "lalalalala"
            }
        }
    }
}

struct ExpandingTextView_Previews: PreviewProvider {
    static var previews: some View {
        CobaanLagi()
    }
}
