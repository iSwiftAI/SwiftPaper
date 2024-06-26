//
//  FilterView.swift
//  SwiftPaper
//
//  Created by Niall Lv on 2022/9/2.
//

import SwiftUI

struct FilterView: View {
    @Binding var showFilterView: Bool
    
    @Binding var selectedFields: [String]
    @Binding var selectedClasses: [String]
    @Binding var conferenceOrJournal: Int
    @Binding var englishOrChinese: Int
    
    @State var allFields = ["计算机体系结构/并行与分布计算/存储系统", "计算机网络", "网络与信息安全", "软件工程/系统软件/程序设计语言", "数据库/数据挖掘/内容检索", "计算机科学理论", "计算机图形学与多媒体", "人工智能", "人机交互与普适计算", "交叉/综合/新兴"]
    
    @State var allClasses = ["A 类", "B 类", "C 类", "非 CCF 推荐列表"]
    
    
    @State var hideConferenceSelection = false
    
    var body: some View {
        NavigationStack {
           Form {
               Section {
                   ForEach(allClasses, id: \.self) { field in
                       Button {
                           withAnimation(.easeInOut(duration: 0.1)) {
                               if self.selectedClasses.contains(field) {
                                   self.selectedClasses.removeAll(where: { $0 == field })
                               } else {
                                   self.selectedClasses.append(field)
                               }
                           }
                       } label: {
                           HStack {
                               Text(LocalizedStringKey(field)).foregroundColor(.primary)
                               Spacer()
                               Image(systemName: "checkmark")
                                   .font(.system(size: 17.5, weight: .semibold, design: .default))
                                   .opacity(self.selectedClasses.contains(field) ? 1.0 : 0.0)
                           }
                       }
                       .buttonStyle(PlainButtonStyle())
                   }
               } header: {
                   HStack {
                       Text("选择类别")
                       Spacer()
                       Button {
                           if selectedClasses.count == allClasses.count { self.selectedClasses = [] }
                           else { self.selectedClasses = allClasses }
                       } label: {
                           Text("全选").font(.caption)
                       }
                   }
               }
               
               Section {
                   ForEach(allFields, id: \.self) { field in
                       Button {
                           withAnimation(.easeInOut(duration: 0.1)) {
                               if self.selectedFields.contains(field) {
                                   self.selectedFields.removeAll(where: { $0 == field })
                               } else {
                                   self.selectedFields.append(field)
                               }
                           }
                       } label: {
                           HStack {
                               Text(LocalizedStringKey(field)).foregroundColor(.primary)
                               Spacer()
                               Image(systemName: "checkmark")
                                   .font(.system(size: 17.5, weight: .semibold, design: .default))
                                   .opacity(self.selectedFields.contains(field) ? 1.0 : 0.0)
                           }
                       }
                       .buttonStyle(PlainButtonStyle())
                   }
               } header: {
                   HStack {
                       Text("选择领域")
                       Spacer()
                       Button {
                           if selectedFields.count == allFields.count { self.selectedFields = [] }
                           else { self.selectedFields = allFields }
                       } label: {
                           Text("全选").font(.caption)
                       }
                   }
               }
               if !hideConferenceSelection {
                   Section {
                       Picker("选择会议或期刊", selection: $conferenceOrJournal) {
                           Text("显示会议与期刊").tag(0)
                           Text("仅显示会议").tag(1)
                           Text("仅显示期刊").tag(2)
                       }
                       .labelsHidden()
                       .pickerStyle(.inline)
                   } header: {
                       Text("选择会议或期刊")
                   }
                   Section {
                       Picker("选择国际或中文", selection: $englishOrChinese) {
                           Text("显示国际与中文").tag(0)
                           Text("仅显示国际").tag(1)
                           Text("仅显示中文").tag(2)
                       }
                       .labelsHidden()
                       .pickerStyle(.inline)
                   } header: {
                       Text("选择国际或中文")
                   }
                   
                   Button(action: {
                       self.englishOrChinese = 0
                       self.conferenceOrJournal = 0
                       self.selectedFields = allFields
                   }, label: {
                       Text("重置筛选")
                   })
                   .buttonStyle(PlainButtonStyle())
               }
           }
           .toolbar {
               ToolbarItem(placement: .confirmationAction) {
                   Button {
                       showFilterView = false
                   } label: {
                       Text("完成")
                   }
               }
               ToolbarItem(placement: .cancellationAction) {
                   Button(action: {
                       self.englishOrChinese = 0
                       self.conferenceOrJournal = 0
                       self.selectedFields = allFields
                       self.selectedClasses = allClasses
                   }, label: {
                       Text("重置筛选")
                   })
               }
           }
           .formStyle(.grouped)
           .navigationTitle(Text("筛选"))
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(showFilterView:.constant(true), selectedFields: .constant([]), selectedClasses: .constant([]), conferenceOrJournal: .constant(0), englishOrChinese: .constant(0))
    }
}

