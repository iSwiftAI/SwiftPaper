//
//  AppSideBarNavigation-macOS.swift
//  SwiftPaper
//
//  Created by Niall Lv on 2023/1/7.
//

import SwiftUI

@available(iOS 16.0, macOS 13.0, *)
struct AppSideBarNavigation_macOS: View {
    
    @State var searchCCFModel: String = ""
    @State var searchDeadLine: String = ""
    
    @State private var selection: NavigationItem? = .ccflist
    
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(selection: $selection) {
                Label("推荐列表", systemImage: "list.bullet").tag(NavigationItem.ccflist)
                Label("会议征稿信息", systemImage: "newspaper").tag(NavigationItem.deadlines)
                Label("设置", systemImage: "gear").tag(NavigationItem.settings)
            }
            .navigationTitle(Text("SwiftPaper"))
            .navigationSplitViewColumnWidth(min: 150, ideal: 200, max: 300)
        } detail: {
            NavigationStack {
                switch selection {
                case .none, .ccflist:
                    CCFList(searchText: $searchCCFModel)
                        .searchable(text: $searchCCFModel, placement: .automatic, prompt: "搜索")
                        .disableAutocorrection(true)
                case .deadlines:
                    DeadLinesList(searchText: $searchDeadLine)
                        .searchable(text: $searchDeadLine, placement: .automatic, prompt: "搜索")
                        .disableAutocorrection(true)
                case .settings:
                    SettingsView()
                }
            }
        }
        .frame(minWidth: 600, minHeight: 450)
    }
}

@available(iOS 16.0, macOS 13.0, *)
struct AppSideBarNavigation_macOS_Previews: PreviewProvider {
    static var previews: some View {
        AppSideBarNavigation_macOS()
    }
}
