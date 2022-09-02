//
//  DeadLinesList.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/29.
//

import SwiftUI
import SPIndicator

struct DeadLinesList: View {
    @EnvironmentObject var deadlineStore: DeadLineStore
    @EnvironmentObject var ccfStore: CCFStore
    
    @Binding var searchText: String
    
    @State var conferenceOrJournal: Int = 0
    @State var englishOrChinese: Int = 0
    @State var selectedFields: [String] = ["计算机体系结构/并行与分布计算/存储系统", "计算机网络", "网络与信息安全", "软件工程/系统软件/程序设计语言", "数据库/数据挖掘/内容检索", "计算机科学理论", "计算机图形学与多媒体", "人工智能", "人机交互与普适计算", "交叉/综合/新兴"]
    @State var showFilterView = false
    
    var body: some View {
        Group {
            if !deadlineStore.successfullyLoaded && filterResult.isEmpty && !deadlineStore.loading {
                NetworkErrorView {
                    await deadlineStore.fetch(force: true)
                }
            } else if deadlineStore.loading {
                ProgressView()
            } else {
                if filterResult.isEmpty {
                    EmptyCCFView()
                } else {
                    List(filterResult) { deadLine in
                        NavigationLink(destination: CCFDetailView(model: ccfStore.getCCFModel(deadLine: deadLine)!, deadline: deadLine)) {
                            DeadLinesRow(deadLine: deadLine)
                        }
                    }
                }
            }
        }
        .SPIndicator(isPresent: $deadlineStore.showIndicator,
                     title: ccfStore.successfullyLoaded ? String(localized: "更新成功") : String(localized: "更新失败"),
                     message: ccfStore.errorDescription,
                     preset: ccfStore.successfullyLoaded ? .done : .error,
                     haptic: ccfStore.successfullyLoaded ? .success : .error)
        .refreshable { await self.deadlineStore.fetch(force: true)}
        .sheet(isPresented: $showFilterView) {
            FilterView(showFilterView: $showFilterView, selectedFields: $selectedFields, conferenceOrJournal: $conferenceOrJournal, englishOrChinese: $englishOrChinese, hideConferenceSelection: true)
        }
        .toolbar(content: toolbarItems)
        .navigationTitle(Text("Call For Papers"))
    }
    
    @ToolbarContentBuilder func toolbarItems() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            
            if self.deadlineStore.refreshing {
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
            let model = ccfStore.getCCFModel(deadLine: model)!
            let check1 = self.selectedFields.contains(model.field)
            let check2 = self.englishOrChinese == 0 || model.region == (self.englishOrChinese == 1 ? "国际" : "中文")
            let check3 = self.conferenceOrJournal == 0 || model.form == (self.conferenceOrJournal == 1 ? "会议" : "期刊")
            return check1 && check2 && check3
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
