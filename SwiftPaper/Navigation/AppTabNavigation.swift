//
//  AppTabNavigation.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/7/14.
//

import SwiftUI

struct AppTabNavigation: View {
    var body: some View {
        TabView {
            NavigationView {
                CCFList()
            }
            .tabItem {
                Label("推荐列表", systemImage: "list.bullet")
            }
            
            NavigationView {
                EmptyView()
            }
            .tabItem {
                Label("会议征稿信息", systemImage: "newspaper")
            }

            NavigationView {
                SettingsView()
            }
            .tabItem {
                Label("设置", systemImage: "gear")
            }
        }
    }
}

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
    }
}
