//
//  DeadLineDetailView.swift
//  SwiftPaper
//
//  Created by Niall Lv on 2023/8/4.
//

import SwiftUI

struct DeadLineDetailView: View {
    @EnvironmentObject var deadlineStore: DeadLineStore
    var model: CCFModel?
    var deadLine: DeadLine
    
    @State var countDown = "00d:00h:00m:00s"
    @State var futureDate: Date = Date()
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State var url: URL? = nil
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    VStack {
                        RankView(rank: deadLine.rank.ccf, width: 100, height: 100)
                        Text(LocalizedStringKey("\(deadLine.rank.ccf) 类")).foregroundColor(.secondary)
                        Text(deadLine.title + " \(deadLine.latestConf.year)")
                            .font(.system(.title, design: .rounded))
                            .bold()
                        
                        Text(deadLine.description)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true).font(.title2)
                        Text(countDown)
                            .font(.system(.title, design: .rounded))
                            .foregroundStyle(self.futureDate > Date() ? LinearGradientColors[deadLine.rank.ccf] ?? LinearGradientColors["Non-CCF"]! : .linearGradient(colors: [.gray], startPoint: .leading, endPoint: .trailing))
                            .padding(4)
                    }
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            DeadLineConfs(conf: deadLine.latestConf, header: "会议征稿信息", abbreviation: deadLine.title, timeZone: deadLine.latestConf.timezone)
            
            if let model = self.model {
                Section {
                    TextinForm(Title: "国际/中文", Content: model.region)
                    TextinForm(Title: "领域", Content: model.field)
                        .multilineTextAlignment(.trailing)
                    TextinForm(Title: "出版社", Content: model.press)
                    Link(destination: URL(string: model.site) ?? URL(string: "https://dblp.org/")!) {
                        Label("访问 dblp 链接", systemImage: "safari")
                    }
                }
            }
            
            Section {
                TextinForm(Title: "CORE", Content: deadLine.rank.core ?? "N/A")
                TextinForm(Title: "THCPL", Content: deadLine.rank.thcpl ?? "N/A")
            } header: {
                Text("其它评级")
            }
            
            NavigationLink(destination: AllDeadLines(confs: deadLine.confs, abbreviation: deadLine.title)) {
                Text("历届会议信息")
            }
        }
        .formStyle(.grouped)
        .navigationTitle(Text("详细信息"))
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .task {
            self.futureDate = self.deadLine.latestConf.nearestDeadLineDate
            if futureDate < Date() {
                self.timer.upstream.connect().cancel()
            } else {
                self.countDown = countDownString(from: self.futureDate, until: Date())
            }
        }
        .onReceive(timer) { time in
            if futureDate > Date() {
                self.countDown = countDownString(from: self.futureDate, until: Date())
            }
        }
    }
}

struct DeadLineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DeadLineDetailView(deadLine: DeadLineStore.placeholderCCF[0])
            .environmentObject(DeadLineStore())
    }
}
