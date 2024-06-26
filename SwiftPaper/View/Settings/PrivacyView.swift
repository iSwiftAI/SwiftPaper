//
//  PrivacyView.swift
//  SwiftPaper (iOS)
//
//  Created by 吕丁阳 on 2021/11/9.
//

import SwiftUI

struct PrivacyView: View {
    let filepath = Bundle.main.url(forResource: "Privacy", withExtension: "md")
    @State private var fileContent: String = ""
    
    var body: some View {
        ScrollView {
            Text(try! AttributedString(markdown: fileContent, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                .padding()
        }
        .navigationTitle(Text("Privacy"))
        .task {
            loadFileContent()
        }
    }
    
    private func loadFileContent() {
        guard let filepath = filepath else {
            print("File not found")
            return
        }
        do {
            let content = try String(contentsOf: filepath)
            fileContent = content
        } catch {
            print("Failed to load file content: \(error.localizedDescription)")
        }
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
