//
//  AllDeadlines.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/28.
//

import SwiftUI

struct AllDeadLines: View {
    @State var confs: [DeadLine.Conf]
    var abbreviation = ""
    
    var body: some View {
        Form {
            ForEach(confs, id: \.self) { conf in
                DeadLineConfs(conf: conf, abbreviation: abbreviation)
            }
            .onAppear {
                self.confs = confs.sorted {$0.year > $1.year}
            }
        }
        .formStyle(.grouped)
        .navigationTitle(Text("历届会议"))
    }
}

struct AllDeadLines_Previews: PreviewProvider {
    static var previews: some View {
        AllDeadLines(confs: DeadLineStore.placeholderCCF[0].confs)
    }
}
