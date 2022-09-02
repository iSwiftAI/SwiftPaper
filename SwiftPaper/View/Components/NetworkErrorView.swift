//
//  NetworkErrorView.swift
//  SwiftPaper
//
//  Created by Niall Lv on 2022/9/2.
//

import SwiftUI

struct NetworkErrorView: View {
    var action: () async -> Void = {}
    
    var body: some View {
        VStack {
            Image("network")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 500)
                
            Text("似乎网络发生了错误，检查网络设置，并刷新试试吧～")
                .padding()
            Button {
                Task { await action() }
            } label: {
                Label("刷新", systemImage: "arrow.clockwise")
            }
            .tint(.indigo)
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding(.bottom)
        }
        .padding()
        
    }
}

struct NetworkErrorView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkErrorView()
    }
}
