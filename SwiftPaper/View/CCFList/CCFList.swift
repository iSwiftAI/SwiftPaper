//
//  CCFList.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/10/12.
//

import SwiftUI
import SPIndicator

struct CCFList: View {
    @EnvironmentObject var ccfStore: CCFStore
    
    @Binding var searchText: String
    
    @State var conferenceOrJournal: Int = 0
    @State var englishOrChinese: Int = 0
    @State var selectedFields: [String] = ["计算机体系结构/并行与分布计算/存储系统", "计算机网络", "网络与信息安全", "软件工程/系统软件/程序设计语言", "数据库/数据挖掘/内容检索", "计算机科学理论", "计算机图形学与多媒体", "人工智能", "人机交互与普适计算", "交叉/综合/新兴"]
    
    @State var showFilterView = false
    
    
    var body: some View {
        
        Group {
            if !ccfStore.successfullyLoaded && filterResult.isEmpty && !ccfStore.loading {
                NetworkErrorView {
                    await ccfStore.fetch(force: true)
                }
            } else if ccfStore.loading {
                ProgressView()
            } else {
                if filterResult.isEmpty {
                    EmptyCCFView()
                } else {
                    if #available(iOS 16, *) {
                        List(filterResult) { model in
                            NavigationLink(value: model) {
                                CCFRow(model: model)
                            }
                        }
                        .navigationDestination(for: CCFModel.self) { model in
                            CCFDetailView(model: model)
                        }
                    } else {
                        List(filterResult) { model in
                            NavigationLink(destination: CCFDetailView(model: model)) {
                                CCFRow(model: model)
                            }
                        }
                    }
                    
                }
            }
        }
        .SPIndicator(isPresent: $ccfStore.showIndicator,
                     title: ccfStore.successfullyLoaded ? String(localized: "更新成功") : String(localized: "更新失败"),
                     message: ccfStore.errorDescription,
                     preset: ccfStore.successfullyLoaded ? .done : .error,
                     haptic: ccfStore.successfullyLoaded ? .success : .error)
        
        .refreshable { await ccfStore.fetch(force: true) }
        .sheet(isPresented: $showFilterView) {
            FilterView(showFilterView: $showFilterView, selectedFields: $selectedFields, conferenceOrJournal: $conferenceOrJournal, englishOrChinese: $englishOrChinese)
        }
        .toolbar(content: toolbarItems)
        .navigationTitle(Text("SwiftPaper"))
    }
    
    
    @ToolbarContentBuilder func toolbarItems() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if self.ccfStore.refreshing {
                ProgressView()
            } else {
                Button {
                    Task { await ccfStore.fetch(force: true) }
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
    
    var searchResult: [CCFModel] {
        if searchText.isEmpty {
            return ccfStore.ccfModels
        } else {
            return searchFilter()
        }
    }
    var filterResult: [CCFModel] {
        
        return searchResult.filter { model in
            let check1 = self.selectedFields.contains(model.field) || model.region == "中文"
            let check2 = self.englishOrChinese == 0 || model.region == (self.englishOrChinese == 1 ? "国际" : "中文")
            let check3 = self.conferenceOrJournal == 0 || model.form == (self.conferenceOrJournal == 1 ? "会议" : "期刊")
            return check1 && check2 && check3
        }
        
        
        
//        if conferenceOrJournal == 0 && englishOrChinese == 0 {
//            return searchResult
//        } else if conferenceOrJournal == 0 {
//            return searchResult.filter { model in
//                if model.region == (self.englishOrChinese == 1 ? "国际" : "中文") {
//                    return true
//                }
//                return false
//            }
//        } else if englishOrChinese == 0 {
//            return searchResult.filter { model in
//                if model.form == (self.conferenceOrJournal == 1 ? "会议" : "期刊") {
//                    return true
//                }
//                return false
//            }
//        } else {
//            return searchResult.filter { model in
//                if model.region == (self.englishOrChinese == 1 ? "国际" : "中文") && model.form == (self.conferenceOrJournal == 1 ? "会议" : "期刊") {
//                    return true
//                }
//                return false
//            }
//        }
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
