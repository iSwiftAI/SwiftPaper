//
//  AppSidebarNavigation.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/7/14.
//

import SwiftUI

struct AppSidebarNavigation: View {
    
    enum NavigationItem {
        case ccflist
        case deadlines
        case settings
    }
    @State var searchCCFModel: String = ""
    @State var searchDeadLine: String = ""
    
    @State private var selection: NavigationItem? = .ccflist
    
//    @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    
    var body: some View {
        if #available(iOS 16, *) {
            NavigationSplitView(columnVisibility: .constant(NavigationSplitViewVisibility.doubleColumn)) {
                List(selection: $selection) {
                    Label("推荐列表", systemImage: "list.bullet").tag(NavigationItem.ccflist)
                    Label("会议征稿信息", systemImage: "newspaper").tag(NavigationItem.deadlines)
                    Label("设置", systemImage: "gear").tag(NavigationItem.settings)
                }
                .navigationTitle(Text("SwiftPaper"))
            } detail: {
                NavigationStack {
                    switch selection {
                    case .none, .ccflist:
                        CCFList(searchText: $searchCCFModel)
                            .searchable(text: $searchCCFModel, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
                            .disableAutocorrection(true)
                    case .deadlines:
                        DeadLinesList(searchText: $searchDeadLine)
                            .searchable(text: $searchDeadLine, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
                            .disableAutocorrection(true)
                    case .settings:
                        SettingsView()
                    }
                }
            }
            .navigationSplitViewStyle(.balanced)
        } else {
            NavigationView {
                List {
                    NavigationLink(tag: NavigationItem.ccflist, selection: $selection) {
                        CCFList(searchText: $searchCCFModel)
                            .searchable(text: $searchCCFModel, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
                            .disableAutocorrection(true)
                    } label: {
                        Label("推荐列表", systemImage: "list.bullet")
                    }
                    
                    NavigationLink(tag: NavigationItem.deadlines, selection: $selection) {
                        DeadLinesList(searchText: $searchDeadLine)
                            .searchable(text: $searchDeadLine, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
                            .disableAutocorrection(true)
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
        }
    }
}

struct AppSidebarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSidebarNavigation()
    }
}
