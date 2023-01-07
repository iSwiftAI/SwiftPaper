//
//  SettingsView.swift
//  SwiftPaper (iOS)
//
//  Created by 吕丁阳 on 2021/11/9.
//

import SwiftUI
#if canImport(MessageUI)
import MessageUI
#endif

struct SettingsView: View {
    // App version
    let version = Bundle.main.appVersionShort
    let build = Bundle.main.appVersionLong
    let appName = Bundle.main.appName
#if os(iOS)
    // mail
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    // share
    @State var showPopover = false
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
#endif
    // welcome view
    @AppStorage("showWelcome") var showWelcome: Bool = false
    
    // AppIcon
    @AppStorage("appIcon") var appIcon: String = "Default"
    
    
    var body: some View {
        
        Form {
            // App Icon
            Section {
                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        //                        Image(uiImage: UIImage(named: getHPrimaryIconName()!) ?? UIImage())
                        Image(appIcon+"Image")
                        //                            .renderingMode(.original)
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
#if os(iOS)
                NavigationLink {
                    AppearanceView()
                } label: {
                    Label {
                        Text("外观")
                    } icon: {
                        Image(systemName: "paintbrush.fill")
                            .foregroundColor(.indigo)
                    }
                }
                
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
#endif
                if #available(iOS 16, macOS 13, *) {
                    ShareLink(item: AppURL) {
                        Label {
                            Text("推荐应用给朋友").foregroundColor(.primary)
                        } icon: {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(Color.blue)
                        }
                    }
                } else {
#if os(iOS)
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
                    })
#endif
                }
                
                
            }
            
            // About
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
                Link(destination: URL(string: "https://swiftpaper.top")!) {
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
                    Text("\(version) (\(build)) © iSwiftAI").foregroundColor(.secondary).font(.subheadline)
                    Spacer()
                }.listRowBackground(Color.clear)
            }
        }
#if os(macOS)
        .formStyle(.grouped)
#endif
        .navigationTitle(Text("设置"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
