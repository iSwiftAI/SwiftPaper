//
//  PrivacyView.swift
//  SwiftPaper (iOS)
//
//  Created by 吕丁阳 on 2021/11/9.
//

import SwiftUI
import SwiftyMarkdown

struct PrivacyView: View {
    let filepath = Bundle.main.url(forResource: "Privacy", withExtension: "md")
    var body: some View {
        UIKTextView(text: .constant(SwiftyMarkdown(url: filepath!)!.attributedString()))
        .navigationTitle(Text("Privacy"))
        
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}

struct UIKTextView: UIViewRepresentable {
    @Binding var text: NSAttributedString

    func makeUIView(context: Context) -> UITextView {
        UITextView()
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
        uiView.isEditable = false
        uiView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
