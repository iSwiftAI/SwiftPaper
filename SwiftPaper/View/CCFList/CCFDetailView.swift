//
//  CCFDetailView.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/10/12.
//

import SwiftUI
import BetterSafariView

struct CCFDetailView: View {
    @EnvironmentObject var deadlineStore: DeadLineStore
    
    @State var model: CCFModel
    
    @State var deadline: DeadLine?
    @State var url: URL? = nil
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    VStack {
                        RankView(rank: model.rank, width: 100, height: 100)
                        Text(model.rank+" 类"+model.form)
                            .foregroundColor(.secondary)
                        if !model.abbreviation.isEmpty {
                            Text(model.abbreviation)
                                .font(.system(.title, design: .rounded))
                                .bold()
                        }
                        Text(model.fullName)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true).font(.title2)
                    }
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            
            Section {
                TextinForm(Title: "国际/中文", Content: model.region)
                TextinForm(Title: "领域", Content: model.field)
                    .multilineTextAlignment(.trailing)
                TextinForm(Title: "出版社", Content: model.press)
                Button(action: {
                    self.url = URL(string: model.site)!
                }) {
                    Label("访问 DBLP 链接", systemImage: "safari")
                }
                .safariView(item: $url) { url in
                    SafariView(
                        url: url,
                        configuration: SafariView.Configuration(
                            entersReaderIfAvailable: false,
                            barCollapsingEnabled: true
                        )
                    )
                }
            }
            .task {
//                await self.deadlineStore.fetch()
                if self.deadline == nil {
                    self.deadline = deadlineStore.getDeadLine(ccfModel: self.model)
                }
            }
            
            if (self.deadline != nil) {
                DeadLineConfs(conf: deadline!.confs.last!, header: "会议征稿信息", abbreviation: self.model.abbreviation, timeZone: deadline!.confs.last!.timezone)
                
                NavigationLink(destination: AllDeadLines(confs: deadline!.confs, abbreviation: self.model.abbreviation)) {
                    Text("历届会议信息")
                }
                
            }
        }
        .navigationTitle(Text("详细信息"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CCFDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CCFDetailView(model: CCFStore.placeholderCCF.filter {$0.fullName == "International Joint Conference on Artificial Intelligence"}.first!)
                .environmentObject(DeadLineStore())
        }
        NavigationView {
            CCFDetailView(model: CCFStore.placeholderCCF.filter {$0.fullName == "IEEE Symposium on Security and Privacy"}.first!)
                .environmentObject(DeadLineStore())
        }
        
    }
}


struct TextinForm: View {
    @State var Title: String
    @State var Content: String
    
    var body: some View {
        HStack {
            Text(Title)
            Spacer()
            Text(Content).foregroundColor(.secondary)
        }
        .multilineTextAlignment(.trailing)
    }
}
