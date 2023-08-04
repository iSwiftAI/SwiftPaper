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
        VStack {
            Image("network")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 500)
                
            Text("似乎网络发生了错误，检查网络设置，并刷新试试吧～")
                .padding()
            Text("错误描述：").font(.caption) + Text(errorString ?? "").font(.caption)
            Text("网络状态：").font(.caption) + Text(networkMonitor.isConnected ? "正常" : "断开").font(.caption)
            Button {
                Task { await action() }
            } label: {
                Label("刷新", systemImage: "arrow.clockwise")
            }
            .tint(.indigo)
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding(.horizontal)
            
        }
        .padding()
        
    }
}

struct NetworkErrorView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkErrorView()
    }
}
