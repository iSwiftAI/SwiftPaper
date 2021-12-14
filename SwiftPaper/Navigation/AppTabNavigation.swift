//
//  AppTabNavigation.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/7/14.
//

import SwiftUI

struct AppTabNavigation: View {
    @State var searchCCFModel: String = ""
    @State var searchDeadLine: String = ""
    
    var body: some View {
        TabView {
            if #available(iOS 15.0, *) {
                NavigationView {
                    CCFList(searchText: $searchCCFModel)
                }
                .searchable(text: $searchCCFModel, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
                .disableAutocorrection(true)
                .tabItem {
                    Label("推荐列表", systemImage: "list.bullet")
                }
            } else {
                NavigationView {
                    CCFList(searchText: $searchCCFModel)
                        .navigationBarSearch($searchCCFModel, placeholder: "搜索", hidesNavigationBarDuringPresentation: true, hidesSearchBarWhenScrolling: false, cancelClicked: {}, searchClicked: {})
        //                .searchable(text: $searchCCFModel, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
                        .disableAutocorrection(true)
                }
                
                .tabItem {
                    Label("推荐列表", systemImage: "list.bullet")
                }
            }
            
            if #available(iOS 15.0, *) {
                NavigationView {
                    DeadLinesList(searchText: $searchDeadLine)
                }
                .searchable(text: $searchDeadLine, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
                .disableAutocorrection(true)
                .tabItem {
                    Label("会议征稿信息", systemImage: "newspaper")
                }
            } else {
                NavigationView {
                    DeadLinesList(searchText: $searchDeadLine)
                        .navigationBarSearch($searchDeadLine, placeholder: "搜索", hidesNavigationBarDuringPresentation: true, hidesSearchBarWhenScrolling: false, cancelClicked: {}, searchClicked: {})
        //                .searchable(text: $searchDeadLine, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
                        .disableAutocorrection(true)
                }
                
                .tabItem {
                    Label("会议征稿信息", systemImage: "newspaper")
                }
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
