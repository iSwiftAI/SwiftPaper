//
//  AppSidebarNavigation.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/7/14.
//

import SwiftUI

struct AppSidebarNavigation: View {
    
    var body: some View {
#if os(iOS)
        if #available(iOS 16, *) {
            AppSidebarNavigation16()
        } else {
            AppSidebarNavigation15()
        }
#else
        AppSidebarNavigation16()
#endif
    }
}

@available(iOS 16.0, *)
struct AppSidebarNavigation16: View {
    
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
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 150, ideal: 200, max: 300)
#endif
        } detail: {
            NavigationStack {
                
                switch selection {
                case .none, .ccflist:
                    CCFList(searchText: $searchCCFModel)
#if os(iOS)
                        .searchable(text: $searchCCFModel, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
#else
                        .searchable(text: $searchCCFModel, placement: .automatic, prompt: "搜索")
#endif
                        .disableAutocorrection(true)
                    
                case .deadlines:
                    DeadLinesList(searchText: $searchDeadLine)
#if os(iOS)
                        .searchable(text: $searchDeadLine, placement: .navigationBarDrawer(displayMode: .always), prompt: "搜索")
#else
                        .searchable(text: $searchDeadLine, placement: .automatic, prompt: "搜索")
#endif
                        .disableAutocorrection(true)
                case .settings:
                    SettingsView()
                }
                
            }
            
        }
#if os(macOS)
        .frame(minWidth: 600, minHeight: 450)
#endif
        .navigationSplitViewStyle(.automatic)
        
    }
}

#if os(iOS)
struct AppSidebarNavigation15: View {
    
    @State var searchCCFModel: String = ""
    @State var searchDeadLine: String = ""
    
    @State private var selection: NavigationItem? = .ccflist
    
    var body: some View {
        
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
#endif

enum NavigationItem {
    case ccflist
    case deadlines
    case settings
}


struct AppSidebarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSidebarNavigation()
    }
}
