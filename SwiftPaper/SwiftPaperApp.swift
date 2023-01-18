//
//  SwiftPaperApp.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/9.
//

import SwiftUI

@main
struct SwiftPaperApp: App {
#if os(iOS)
    @StateObject var appThemeViewModel = AppThemeViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    UIApplication.shared.keyWindow?.tintColor = UIColor(appThemeViewModel.appTintColor)
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = appThemeViewModel.isDarkMode == 1 ? .dark : appThemeViewModel.isDarkMode == 0 ? .light : .unspecified
                }
        }
    }
#elseif os(macOS)
    var body: some Scene {
        WindowGroup {
            ContentView_macOS()
        }
        .defaultSize(width: 1000, height: 650)
    }
#endif
}
public var AppURL = URL(string: "https://itunes.apple.com/app/id1640972298")!
