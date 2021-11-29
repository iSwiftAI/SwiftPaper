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
    
    var body: some View {
        Group {
            if deadlineStore.loading {
                ProgressView()
            } else {
                if filterResult.isEmpty {
                    EmptyCCFView()
                } else {
                    List(filterResult) { deadLine in
//                    List(deadlineStore.deadLines) { deadLine in
                        NavigationLink(destination: CCFDetailView(model: ccfStore.getCCFModel(deadLine: deadLine)!, deadline: deadLine)) {
                            DeadLinesRow(deadLine: deadLine)
                        }
                    }
                }
            }
        }
        .refreshable { await self.deadlineStore.fetch(force: true) }
        .toolbar(content: toolbarItems)
        .navigationTitle(Text("Deadlines"))
    }
    
    @ToolbarContentBuilder func toolbarItems() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button {
                    Task {
                        await self.deadlineStore.fetch(force: true)
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
        
        return searchResult.sorted {
            let date1 = $0.confs.last!.timeline.last!.deadline.localdate(timeZone: $0.confs.last!.timezone)
            let date2 = $1.confs.last!.timeline.last!.deadline.localdate(timeZone: $1.confs.last!.timezone)
            let nowDate = Date()
            if date1 > nowDate && date2 <= nowDate { return true }
            else if date2 > nowDate && date1 <= nowDate { return false }
            else if date1 <= nowDate && date2 <= nowDate { return false }
            else if date1 > nowDate && date2 > nowDate && date1 < date2 { return true }
            else { return false }
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
