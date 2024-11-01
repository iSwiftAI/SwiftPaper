//
//  NetworkErrorView.swift
//  SwiftPaper
//
//  Created by Niall Lv on 2022/9/2.
//

import SwiftUI

struct NetworkErrorView: View {
    @State var errorString: String?
    var action: () async -> Void = {}
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        Form {
            Section {
                Image("network")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 500)
                Text("数据加载发生了错误，检查网络设置，将 SwiftPaper 更新到最新版。")
            }
            
            
            Section("Detail") {
                Text("错误描述：") + Text(errorString ?? "")
                Text("网络状态：") + Text(networkMonitor.isConnected ? "正常" : "断开")
            }
            Section {
                Button {
                    Task { await action() }
                } label: {
                    Text("刷新")
                }
                Link("App 检查更新", destination: URL(string: "https://itunes.apple.com/app/id1640972298")!)
            }
            
        }
        
    }
}

struct NetworkErrorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NetworkErrorView()
        }
    }
}
