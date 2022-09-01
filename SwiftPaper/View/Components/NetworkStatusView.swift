//
//  NetworkStatusView.swift
//  SwiftPaper
//
//  Created by Niall Lv on 2022/9/1.
//

import SwiftUI

struct NetworkStatusView: View {
    @StateObject var networkMonitor = NetworkMonitor()
    var body: some View {
        Text(networkMonitor.isConnected ? "Yes" : "No")
    }
}

struct NetworkStatusView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkStatusView()
    }
}
