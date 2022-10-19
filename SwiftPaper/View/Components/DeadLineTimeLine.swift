//
//  DeadLineTimeLine.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/28.
//

import SwiftUI

struct DeadLineTimeLine: View {
    var timeLines: [DeadLine.Conf.Timeline]
    var timeZone = "UTC"
    
    var body: some View {
        Form {
            ForEach(timeLines, id: \.self) { timeLine in
                Section {
                    if (timeLine.abstractDeadline != nil) {
                        TextinFormTap(Title: "摘要截止时间", time: timeLine.abstractDeadline!, timeZone: timeZone)
                    }
                    TextinFormTap(Title: "正文截止时间", time: timeLine.deadline, timeZone: timeZone)
                    if (timeLine.comment != nil) {
                        TextinForm(Title: "备注", Content: timeLine.comment!)
                    }
                } footer: {
                    Text("轻点时间可查看原始时间/本地时间")
                }
            }
        }
        .navigationBarTitle(Text("截稿时间"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeadLineTimeLine_Previews: PreviewProvider {
    static var previews: some View {
        DeadLineTimeLine(timeLines: DeadLineStore.placeholderCCF[0].confs[0].timeline)
    }
}

struct TextinFormTap: View {
    var Title: String
    var time: String
    var timeZone: String
    
    @State var content: String = ""
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(Title))
            Spacer()
            Text(LocalizedStringKey(content))
                .foregroundColor(.secondary)
                .onTapGesture {
                    withAnimation(.easeOut) {
                        let localTime = time.localTimeString(timeZone: timeZone)
                        let orginTime = time + "\n" + timeZone
                        if content == localTime { self.content = orginTime }
                        else if content == orginTime { content = localTime }
                    }
                }
        }
        .multilineTextAlignment(.trailing)
        .onAppear() { //.task
            self.content = time.localTimeString(timeZone: timeZone)
        }
    }
}
