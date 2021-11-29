//
//  AppTabNavigation.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/7/14.
//

import SwiftUI

struct AppTabNavigation: View {
    @State var searchText: String = ""
    
    var body: some View {
        TabView {
            NavigationView {
                CCFList(searchText: $searchText)
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
            .tabItem {
                Label("推荐列表", systemImage: "list.bullet")
            }
            
            NavigationView {
                DeadLinesList()
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
        // 这个 stack 导致返回列表的时候选中状态卡顿
//        .navigationViewStyle(.stack)
    }
}

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
    }
}
