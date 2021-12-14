//
//  AppSidebarNavigation.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/7/14.
//

import SwiftUI
//import NavigationViewKit

struct AppSidebarNavigation: View {
    
    enum NavigationItem {
        case ccflist
        case deadlines
        case settings
    }
    @State var searchCCFModel: String = ""
    @State var searchDeadLine: String = ""
    
    @State private var selection: NavigationItem? = .ccflist
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(tag: NavigationItem.ccflist, selection: $selection) {
                    if #available(iOS 15.0, *) {
                        CCFList(searchText: $searchCCFModel)
                            .searchable(text: $searchCCFModel, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
                            .disableAutocorrection(true)
                    } else {
                        CCFList(searchText: $searchCCFModel)
//                            .searchable(text: $searchCCFModel, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
                            .navigationBarSearch($searchCCFModel, placeholder: "搜索", hidesNavigationBarDuringPresentation: true, hidesSearchBarWhenScrolling: false, cancelClicked: {}, searchClicked: {})
                            .disableAutocorrection(true)
                    }
                } label: {
                    Label("推荐列表", systemImage: "list.bullet")
                }
                
                NavigationLink(tag: NavigationItem.deadlines, selection: $selection) {
                    if #available(iOS 15.0, *) {
                        DeadLinesList(searchText: $searchDeadLine)
                            .searchable(text: $searchDeadLine, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
                            .disableAutocorrection(true)
                    } else {
                        DeadLinesList(searchText: $searchDeadLine)
//                            .searchable(text: $searchDeadLine, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
                            .navigationBarSearch($searchDeadLine, placeholder: "搜索", hidesNavigationBarDuringPresentation: true, hidesSearchBarWhenScrolling: false, cancelClicked: {}, searchClicked: {})
                            .disableAutocorrection(true)
                    }
                } label: {
                    Label("会议征稿信息", systemImage: "newspaper")
                }
                
                NavigationLink(tag: NavigationItem.settings, selection: $selection) {
                    SettingsView()
                } label: {
                    Label("设置", systemImage: "gear")
                }
            }
            .navigationTitle(Text("SwiftPaper"))
            .listStyle(.sidebar)
        }
//        .navigationViewStyle(FixDoubleColumnNavigationViewStyle(widthForLandscape:  320, widthForPortrait: 320))
    }
}

struct AppSidebarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSidebarNavigation()
    }
}
