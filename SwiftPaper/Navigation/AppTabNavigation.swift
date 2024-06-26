//
//  AppTabNavigation.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/7/14.
//
#if os(iOS)
import SwiftUI

struct AppTabNavigation: View {
    @State var searchCCFModel: String = ""
    @State var searchDeadLine: String = ""
    
    var body: some View {
        TabView {
            NavigationStack {
                CCFList(searchText: $searchCCFModel)
            }
            .searchable(text: $searchCCFModel, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
            .disableAutocorrection(true)
            .tabItem {
                Label("推荐列表", systemImage: "list.bullet")
            }
            
            NavigationStack {
                DeadLinesList(searchText: $searchDeadLine)
            }
            .searchable(text: $searchDeadLine, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
            .disableAutocorrection(true)
            .tabItem {
                Label("会议征稿信息", systemImage: "newspaper")
            }
            
            NavigationStack {
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
#endif
