//
//  DeadLinesRow.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/29.
//

import SwiftUI

struct DeadLinesRow: View {
    @State var deadLine: DeadLine
    
    @State var countDown = ""
    @State var futureDate: Date = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            RankView(rank: deadLine.rank)
            VStack(alignment: .leading) {
                Text(deadLine.title + " \(deadLine.confs.last!.year)")
                    .font(.system(.title, design: .rounded))
                    .bold()
                Spacer()
                Text(deadLine.description)
                    .lineLimit(2)
                VStack(alignment: .leading) {
                    Text(deadLine.sub)
                }
                .font(.caption)
                .foregroundColor(.secondary)
                if self.futureDate > Date() {
                    HStack {
                        Image(systemName: "calendar.badge.clock").renderingMode(.original)
                        Text(countDown).bold()
                            .foregroundStyle(LinearGradientColors[deadLine.rank]!)
                    }
                    .font(.system(.title3, design: .rounded))
                }
            }
        }
        .task {
            self.futureDate = self.deadLine.confs.last!.timeline.last!.deadline.localdate(timeZone: self.deadLine.confs.last!.timezone)
            self.countDown = countDownString(from: self.futureDate, until: Date())
        }
        .onReceive(timer) { time in
            self.countDown = countDownString(from: self.futureDate, until: Date())
        }
}
}

struct DeadLinesRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            DeadLinesRow(deadLine: DeadLineStore.placeholderCCF[0])
        }
    }
}

func countDownString(from date: Date, until nowDate: Date) -> String {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day, .hour, .minute, .second] ,from: nowDate, to: date)
    return String(format: "%dd:%02dh:%02d:%02ds",
                  components.day ?? 00,
                  components.hour ?? 00,
                  components.minute ?? 00,
                  components.second ?? 00)
}
