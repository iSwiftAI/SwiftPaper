//
//  PrivacyView.swift
//  SwiftPaper (iOS)
//
//  Created by 吕丁阳 on 2021/11/9.
//

import SwiftUI
import Parma

struct PrivacyView: View {
    let filepath = Bundle.main.url(forResource: "Privacy", withExtension: "md")
    var body: some View {
        ScrollView {
            Parma(try! String(contentsOf: filepath!))
                .padding(.horizontal)
        }
        .navigationTitle(Text("Privacy"))
        
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
