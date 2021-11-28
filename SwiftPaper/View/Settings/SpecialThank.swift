//
//  SpecialThank.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/10/3.
//

import SwiftUI
import BetterSafariView

struct SpecialThank: View {
    @State private var presentingSafariView = false
    @State var url = ""
    
    var body: some View {
        List {
            Section {
                ThankSafariLink(target: "Alamofire", urlString: "https://github.com/Alamofire/Alamofire")
                ThankSafariLink(target: "Parma", urlString: "https://github.com/dasautoooo/Parma")
            } header: {
                Text("开源软件库")
            }
            Section {
                ThankSafariLink(target: "《中国计算机学会推荐国际学术会议和期刊目录》", urlString: "https://www.ccf.org.cn/c/2019-04-25/663625.shtml")
                ThankSafariLink(target: "《中国计算机学会推荐中文科技期刊目录》", urlString: "https://www.ccf.org.cn/ccftjgjxskwml/2020-07-02/704435.shtml")
            } header: {
                Text("其他参考资料")
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
        .navigationBarTitle(Text("鸣谢"))
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    @ViewBuilder func ThankSafariLink(target: String, urlString: String) -> some View {
        
        Button(action: {
            self.presentingSafariView = true
            self.url = urlString
        }) {
            HStack {
                Text(target)
                Spacer()
                Image(systemName: "chevron.right").font(.subheadline)
                    .foregroundColor(Color(UIColor.systemGray2))
            }.foregroundColor(.primary)
        }
    }
    
}

struct SpecialThank_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpecialThank()
        }
    }
}
