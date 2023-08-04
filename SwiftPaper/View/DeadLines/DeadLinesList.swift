//
//  DeadLinesList.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/29.
//

import SwiftUI

struct DeadLinesList: View {
    @EnvironmentObject var deadlineStore: DeadLineStore
    @EnvironmentObject var ccfStore: CCFStore
    
    @Binding var searchText: String
    
    @State var conferenceOrJournal: Int = 0
    @State var englishOrChinese: Int = 0
    @State var selectedFields: [String] = ["计算机体系结构/并行与分布计算/存储系统", "计算机网络", "网络与信息安全", "软件工程/系统软件/程序设计语言", "数据库/数据挖掘/内容检索", "计算机科学理论", "计算机图形学与多媒体", "人工智能", "人机交互与普适计算", "交叉/综合/新兴"]
    @State var selectedClasses: [String] = ["A 类", "B 类", "C 类", "非 CCF 推荐列表"]
    @State var showFilterView = false
    
    var body: some View {
        VStack {
            switch deadlineStore.status {
            case .fail:
                NetworkErrorView(errorString: deadlineStore.errorDescription) {
                    await deadlineStore.fetch(force: true)
                }
            case .loading:
                ProgressView()
            case .success, .refreshing:
                if filterResult.isEmpty {
                    EmptyCCFView()
                } else {
                    List(filterResult) { deadLine in
                        NavigationLink(value: deadLine) {
                            DeadLinesRow(deadLine: deadLine)
                        }
                    }
                    .navigationDestination(for: DeadLine.self) { deadLine in
                        DeadLineDetailView(model: ccfStore.getCCFModel(deadLine: deadLine), deadLine: deadLine)
//                        CCFDetailView(model: ccfStore.getCCFModel(deadLine: deadLine)!, deadline: deadLine)
                    }
                }
            }
        }
        .refreshable { await self.deadlineStore.fetch(force: true)}
        .sheet(isPresented: $showFilterView) {
            FilterView(showFilterView: $showFilterView, selectedFields: $selectedFields, selectedClasses: $selectedClasses, conferenceOrJournal: $conferenceOrJournal, englishOrChinese: $englishOrChinese, hideConferenceSelection: true)
        }
        .toolbar(content: toolbarItems)
        .navigationTitle(Text("Call For Papers"))
    }
    
    @ToolbarContentBuilder func toolbarItems() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            
            if self.deadlineStore.status == .refreshing {
                ProgressView()
            } else {
                Button {
                    Task { await self.deadlineStore.fetch(force: true) }
                } label: {
                    Label("刷新", systemImage: "arrow.clockwise")
                }
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                self.showFilterView = true
            } label: {
                Label("筛选", systemImage: "line.3.horizontal.decrease.circle")
            }
        }
    }
    
    var searchResult: [DeadLine] {
        if searchText.isEmpty {
            return deadlineStore.deadLines
        } else {
            return searchFilter()
        }
    }
    var filterResult: [DeadLine] {
        return searchResult.filter { model in
            var model_rank = ""
            if model.rank != "N" {
                model_rank = model.rank + " 类"
            } else {
                model_rank = "非 CCF 推荐列表"
            }
            return self.selectedClasses.contains(model_rank) && self.selectedFields.contains(model.sub)
        }
    }
    private func searchFilter() -> [DeadLine] {
        let filterResult = deadlineStore.deadLines.filter { deadLine in
            if (deadLine.title.lowercased().contains(searchText.lowercased()) ||
                deadLine.description.lowercased().contains(searchText.lowercased()) ||
                deadLine.sub.lowercased().contains(searchText.lowercased()) ||
                deadLine.rank.lowercased().contains(searchText.lowercased())) {
                return true
            }
            return false
        }
        return filterResult
    }
}

struct DeadLinesList_Previews: PreviewProvider {
    static var previews: some View {
        DeadLinesList(searchText: .constant(""))
            .environmentObject(CCFStore())
            .environmentObject(DeadLineStore())
    }
}
