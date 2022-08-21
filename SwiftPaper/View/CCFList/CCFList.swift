//
//  CCFList.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/10/12.
//

import SwiftUI

struct CCFList: View {
    @EnvironmentObject var ccfStore: CCFStore
    
    @Binding var searchText: String
    
    @State var conferenceOrJournal: Int = 0
    @State var englishOrChinese: Int = 0
    
    var body: some View {
        
        Group {
            if ccfStore.loading {
                ProgressView()
            } else {
                if filterResult.isEmpty {
                    EmptyCCFView()
                } else {
                    List(filterResult) { model in
                        NavigationLink(destination: CCFDetailView(model: model)) {
                            CCFRow(model: model)
                        }
                    }
                }
            }
        }
        .refreshable { await self.ccfStore.fetch(force: true) }
        .toolbar(content: toolbarItems)
        .navigationTitle(Text("SwiftPaper"))
    }
    
    
    @ToolbarContentBuilder func toolbarItems() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                if self.ccfStore.refreshing {
                    ProgressView()
                } else {
                    Button {
                        Task {
                            await self.ccfStore.fetch(force: true)
                        }
                    } label: {
                        Label("刷新", systemImage: "arrow.clockwise")
                    }
                }
                
                Menu {
                    Picker(selection: $conferenceOrJournal) {
                        Text("显示会议与期刊").tag(0)
                        Text("仅显示会议").tag(1)
                        Text("仅显示期刊").tag(2)
                    } label: {
                        Text("显示期刊或会议")
                    }
                    Picker(selection: $englishOrChinese) {
                        Text("显示国内外").tag(0)
                        Text("仅显示国际").tag(1)
                        Text("仅显示中文").tag(2)
                    } label: {
                        Text("显示国内或国外")
                    }
                    Button(action: {
                        self.englishOrChinese = 0
                        self.conferenceOrJournal = 0
                    }, label: {
                        Text("恢复默认筛选条件")
                    })
                } label: {
                    Label("筛选", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
        }
    }
    
    var searchResult: [CCFModel] {
        if searchText.isEmpty {
            return ccfStore.ccfModels
        } else {
            return searchFilter()
        }
    }
    var filterResult: [CCFModel] {
        if conferenceOrJournal == 0 && englishOrChinese == 0 {
            return searchResult
        } else if conferenceOrJournal == 0 {
            return searchResult.filter { model in
                if model.region == (self.englishOrChinese == 1 ? "国际" : "中文") {
                    return true
                }
                return false
            }
        } else if englishOrChinese == 0 {
            return searchResult.filter { model in
                if model.form == (self.conferenceOrJournal == 1 ? "会议" : "期刊") {
                    return true
                }
                return false
            }
        } else {
            return searchResult.filter { model in
                if model.region == (self.englishOrChinese == 1 ? "国际" : "中文") && model.form == (self.conferenceOrJournal == 1 ? "会议" : "期刊") {
                    return true
                }
                return false
            }
        }
    }
    private func searchFilter() -> [CCFModel] {
        let filterResult = ccfStore.ccfModels.filter { model in
            if (model.region.lowercased().contains(searchText.lowercased()) ||
                model.form.lowercased().contains(searchText.lowercased()) ||
                model.field.lowercased().contains(searchText.lowercased()) ||
                model.rank.lowercased().contains(searchText.lowercased()) ||
                model.abbreviation.lowercased().contains(searchText.lowercased()) ||
                model.fullName.lowercased().contains(searchText.lowercased()) ||
                model.press.lowercased().contains(searchText.lowercased()) ||
                model.site.lowercased().contains(searchText.lowercased())) {
                return true
            }
            return false
        }
        return filterResult
    }
}

struct CCFList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CCFList(searchText: .constant(""))
                .environmentObject(CCFStore())
        }
    }
}
