//
//  SpecialThank.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/10/3.
//

import SwiftUI
#if canImport(BetterSafariView)
import BetterSafariView
#endif

struct SpecialThank: View {
    @State private var presentingSafariView = false
    @State var url = ""
    
    @State var updateTime = ""
    
    var body: some View {
#if os(iOS)
        iOSView()
            .navigationTitle(Text("鸣谢"))
            .navigationBarTitleDisplayMode(.inline)
#else
        macOSView()
            .navigationTitle(Text("鸣谢"))
#endif
    }
    
    @ViewBuilder private func macOSView() -> some View {
        Form {
            Section {
                Link(destination: URL(string: "https://github.com/stleamist/BetterSafariView")!) {
                    Text("BetterSafariView")
                }
                Link(destination: URL(string: "https://github.com/SimonFairbairn/SwiftyMarkdown")!) {
                    Text("SwiftyMarkdown")
                }
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
    }
#if os(iOS)
    @ViewBuilder private func iOSView() -> some View {
        Form {
            Section {
                ThankSafariLink(target: "BetterSafariView", urlString: "https://github.com/stleamist/BetterSafariView")
                ThankSafariLink(target: "SwiftyMarkdown", urlString: "https://github.com/SimonFairbairn/SwiftyMarkdown")
                ThankSafariLink(target: "ccf-deadlines", urlString: "https://github.com/ccfddl/ccf-deadlines")
            } header: {
                Text("开源库")
            } footer: {
                Text("更新时间: \(updateTime)")
            }
            Section {
                ThankSafariLink(target: "中国计算机学会推荐国际学术会议和期刊目录", urlString: "https://www.ccf.org.cn/c/2019-04-25/663625.shtml")
                ThankSafariLink(target: "中国计算机学会推荐中文科技期刊目录", urlString: "https://www.ccf.org.cn/c/2019-07-31/667609.shtml")
            } header: {
                Text("其它")
            }
        }
        .onAppear() { //.task
            Task {
                do {
                    updateTime = try await loadUpdateTime(from: URL(string: "https://api.swiftpaper.top/update.log")!, force: true)
                } catch {
                    print(error)
                }
            }
        }
        .background(Text(url).opacity(0)) // 不知道为啥，不然下面66行会崩溃，解包url为空。神奇
        
        .safariView(isPresented: $presentingSafariView) {
            SafariView(
                url: URL(string: self.url)!,
                configuration: SafariView.Configuration(
                    entersReaderIfAvailable: false,
                    barCollapsingEnabled: true
                )
            )
        }
    }
    
    @ViewBuilder func ThankSafariLink(target: String, urlString: String) -> some View {
        
        Button(action: {
            self.presentingSafariView = true
            self.url = urlString
        }) {
            HStack {
                Text(LocalizedStringKey(target))
                Spacer()
                Image(systemName: "chevron.right").font(.subheadline)
                    .foregroundColor(Color(UIColor.systemGray2))
            }.foregroundColor(.primary)
        }
    }
#endif
    
}

struct SpecialThank_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpecialThank()
        }
    }
}
