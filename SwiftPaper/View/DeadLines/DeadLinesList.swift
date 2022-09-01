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
    
    @State var showIndicator = false
    
    var body: some View {
        Group {
            if deadlineStore.loading {
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
        .SPIndicator(isPresent: $showIndicator, title: "更新成功", preset: .done, haptic: .success)
        .refreshable { await self.deadlineStore.fetch(force: true); showIndicator = true }
        .toolbar(content: toolbarItems)
        .navigationTitle(Text("Call For Papers"))
    }
    
    @ToolbarContentBuilder func toolbarItems() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            
            if self.deadlineStore.refreshing {
                ProgressView()
            } else {
                Button {
                    Task {
                        await self.deadlineStore.fetch(force: true)
                        showIndicator = true
                    }
                } label: {
                    Label("刷新", systemImage: "arrow.clockwise")
                }
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
        return searchResult
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
