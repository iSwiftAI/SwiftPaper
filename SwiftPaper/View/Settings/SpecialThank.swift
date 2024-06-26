//
//  SpecialThank.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/10/3.
//

import SwiftUI

struct SpecialThank: View {
    @State private var presentingSafariView = false
    @State var url = ""
    
    @State var updateTime = ""
    
    var body: some View {
        Form {
            Section {
//                Link(destination: URL(string: "https://github.com/stleamist/BetterSafariView")!) {
//                    Text("BetterSafariView")
//                }
//                Link(destination: URL(string: "https://github.com/SimonFairbairn/SwiftyMarkdown")!) {
//                    Text("SwiftyMarkdown")
//                }
                Link(destination: URL(string: "https://github.com/ccfddl/ccf-deadlines")!) {
                    Text("ccf-deadlines")
                }
            } header: {
                Text("开源库")
            } footer: {
                Text("更新时间: \(updateTime)")
            }
            Section {
                Link(destination: URL(string: "https://www.ccf.org.cn/c/2019-04-25/663625.shtml")!) {
                    Text("中国计算机学会推荐国际学术会议和期刊目录")
                }
                Link(destination: URL(string: "https://www.ccf.org.cn/c/2019-07-31/667609.shtml")!) {
                    Text("中国计算机学会推荐中文科技期刊目录")
                }
            } header: {
                Text("其它")
            }
        }
        .task {
            do {
                updateTime = try await loadUpdateTime(from: URL(string: "https://api.swiftpaper.top/update.log")!, force: true)
            } catch {
                print(error)
            }
        }
        .formStyle(.grouped)
        .navigationTitle(Text("鸣谢"))
    }
    
}

struct SpecialThank_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpecialThank()
        }
    }
}
