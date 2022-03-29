//
//  DismissableTextField.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 10/11/21.
//

import Foundation
import SwiftUI
import UIKit

struct DismissableTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var onCommit: (_ value: String) -> Void
        var didBecomeFirstResponder = false
        init(text: Binding<String>, onCommit: @escaping (_ value: String) -> Void) {
            _text = text
            self.onCommit = onCommit
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            onCommit(textField.text ?? "")
            return true
        }
    }
    @Binding var text: String
    var onCommit: (_ value: String) -> Void
    var isFirstResponder: Bool = false
    
    func makeUIView(context: UIViewRepresentableContext<DismissableTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }
    func makeCoordinator() -> DismissableTextField.Coordinator {
        return Coordinator(text: $text, onCommit: onCommit)
    }
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<DismissableTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}
