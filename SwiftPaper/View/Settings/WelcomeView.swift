//
//  WelcomeView.swift
//  SwiftPaper (iOS)
//
//  Created by 吕丁阳 on 2021/11/9.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("showWelcome") var showWelcome: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                Image("welcome")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                Text("SwiftPaper")
                    .font(.system(.largeTitle, design: .rounded))
                Text("**SwiftPaper** 能够助你快速地查询、检索 CCF 计算机推荐期刊、会议列表，并查看该会议期刊的详细信息，能够快速访问查看会议期刊的网址。")
                    .padding()
                Spacer()
                Button {
                    showWelcome = false
                } label: {
                    Label("开始吧～", systemImage: "bolt")
                }
                .tint(.green)
                .buttonStyle(.bordered)
                .controlSize(.large)
                .padding(.bottom)
            }
            
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
