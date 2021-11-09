//
//  SettingsView.swift
//  SwiftPaper (iOS)
//
//  Created by 吕丁阳 on 2021/11/9.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    // App version
    let version = Bundle.main.appVersionShort
    let build = Bundle.main.appVersionLong
    let appName = Bundle.main.appName
    
    // mail
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    // share
    @State var showPopover = false
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    // welcome view
    @AppStorage("showWelcome") var showWelcome: Bool = false
    
    
    var body: some View {
        
        Form {
            Section {
                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        Image(uiImage: UIImage(named: getHPrimaryIconName()!) ?? UIImage())
                            .renderingMode(.original)
                            .IconImageStyle(width: 90)
                        Text(appName)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                        Text("\(version) (\(build)) made with ❤️ by LDY").foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
            Section {
                Button(action: { self.isShowingMailView.toggle() }, label: {
                    Label(title: { Text("反馈问题").foregroundColor(.primary) }) {
                        Image(systemName: "envelope")
                            .foregroundColor(Color.orange)
                    }
                })
                    .disabled(!MFMailComposeViewController.canSendMail())
                    .sheet(isPresented: $isShowingMailView) {
                        MailView(result: self.$result).ignoresSafeArea()
                    }
                Button(action: { rateApp() }, label: {
                    Label(title: { Text("好评鼓励").foregroundColor(.primary) }) {
                        Image(systemName: "star")
                            .foregroundColor(Color.yellow)
                    }
                })
                Button {
                    if horizontalSizeClass == .compact {
                        ShareAppSheet()
                    } else {
                        showPopover = true
                    }
                } label: {
                    Label(title: { Text("推荐应用给朋友").foregroundColor(.primary) }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color.blue)
                    }
                }
                .popover(isPresented: $showPopover, content: {
                    ActivityViewController(activityItems: [AppURL])
                    //                            .modifier(CustomizedThemeModeModifier())
                })
            }
            Section {
                Button(action: { self.showWelcome = true }, label: {
                    Label(title: { Text("查看介绍页面").foregroundColor(.primary) }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.green)
                    }
                })
                    .sheet(isPresented: $showWelcome, onDismiss: {}) {
                        WelcomeView()
                    }
                Link(destination: URL(string: "https://github.com/NiallLDY")!) {
                    Label(title: { Text("关于作者").foregroundColor(.primary) }) {
                        Image(systemName: "person")
                            .foregroundColor(Color.indigo)
                    }
                }
                Link(destination: URL(string: "https://flyswiftai.com/swiftpaper/")!) {
                    Label(title: { Text("APP 网站").foregroundColor(.primary) }) {
                        Image(systemName: "safari")
                            .foregroundColor(Color.blue)
                    }
                }
            }
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
        }
        .navigationTitle(Text("设置"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

func getHPrimaryIconName() -> String? {
    guard let infoPlist = Bundle.main.infoDictionary else { return nil }
    guard let bundleIcons = infoPlist["CFBundleIcons"] as? NSDictionary else { return nil }
    guard let bundlePrimaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? NSDictionary else { return nil }
    guard let bundleIconFiles = bundlePrimaryIcon["CFBundleIconFiles"] as? NSArray else { return nil }
    guard let appIcon = bundleIconFiles.lastObject as? String else { return nil }
    return appIcon
}

extension Bundle {
    
    public var appVersionShort: String {
        if let result = infoDictionary?["CFBundleShortVersionString"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
    public var appVersionLong: String {
        if let result = infoDictionary?["CFBundleVersion"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
    public var appName: String {
        if let result = infoDictionary?["CFBundleName"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
}



