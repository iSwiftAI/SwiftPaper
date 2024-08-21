//
//  SettingsView.swift
//  SwiftPaper (iOS)
//
//  Created by 吕丁阳 on 2021/11/9.
//

import SwiftUI

struct SettingsView: View {
    // App version
    let version = Bundle.main.appVersionShort
    let build = Bundle.main.appVersionLong
    let appName = Bundle.main.appName
    
    // welcome view
    @State private var showWelcome: Bool = false
    
    // AppIcon
    @AppStorage("appIcon") var appIcon: String = "Default"
    
    
    var body: some View {
        
        Form {
            // App Icon
            Section {
                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        Image(appIcon+"Image")
                            .IconImageStyle(width: 90)
                        Text(appName)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                    }
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
            
            // Report & share
            Section {
                Link(destination: EmailURL) {
                    Label(title: { Text("反馈问题").foregroundColor(.primary) }) {
                        Image(systemName: "envelope")
                            .foregroundColor(Color.orange)
                    }
                }
                Link(destination: URL(string: "https://itunes.apple.com/app/id1640972298?action=write-review")!) {
                    Label(title: { Text("好评鼓励").foregroundColor(.primary) }) {
                        Image(systemName: "star")
                            .foregroundColor(Color.yellow)
                    }
                }
                ShareLink(item: AppURL) {
                    Label {
                        Text("推荐应用给朋友").foregroundColor(.primary)
                    } icon: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color.blue)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
            }
            
            // About
            Section {
                Button(action: { showWelcome.toggle() }, label: {
                    Label(title: { Text("查看介绍页面").foregroundColor(.primary) }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.green)
                    }
                })
                .buttonStyle(PlainButtonStyle())
                Link(destination: URL(string: "https://github.com/NiallLDY")!) {
                    Label(title: { Text("关于作者").foregroundColor(.primary) }) {
                        Image(systemName: "person")
                            .foregroundColor(Color.indigo)
                    }
                }
                Link(destination: URL(string: "https://app.iswiftai.com/swiftpaper")!) {
                    Label(title: { Text("APP 网站").foregroundColor(.primary) }) {
                        Image(systemName: "safari")
                            .foregroundColor(Color.blue)
                    }
                }
            }
            
            // Privacy % acknowledgements
            Section {
                NavigationLink(destination: PrivacyView()) {
                    Label(title: { Text("隐私政策") }) {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color.gray)
                    }
                }
                NavigationLink(destination: SpecialThank()) {
                    Label(title: { Text("鸣谢") }) {
                        Image(systemName: "heart")
                            .foregroundColor(Color.red)
                    }
                    
                }
            }
            
            //            NetworkStatusView()
            // Build number
            Section {
                HStack {
                    Spacer()
                    VStack {
                        Text("\(version) (\(build)) © iSwiftAI").font(.subheadline)
                            .padding(.bottom, 5)
                        Link("ICP 备案号：苏ICP备2024111749号-1A", destination: URL(string: "https://beian.miit.gov.cn")!)
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
        }
        .sheet(isPresented: $showWelcome) {
            WelcomeView()
        }
        .formStyle(.grouped)
        .navigationTitle(Text("设置"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

public var AppURL = URL(string: "https://itunes.apple.com/app/id1640972298")!
public var EmailURL: URL {
    let version = Bundle.main.appVersionShort
    let build = Bundle.main.appVersionLong
    let email = "support@iswiftai.com"
    let subject = "SwiftPaper Feedback \(version) (\(build))"
    let body = "\n\n\n App Version: \(version) (\(build)) "
    guard let url = URL(string: "mailto:\(email)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")") else { return URL(string: "mailto:supprot@iswiftai.com")! }
    return url
}
