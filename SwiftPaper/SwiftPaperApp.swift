//
//  SwiftPaperApp.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/9.
//

import SwiftUI

@main
struct SwiftPaperApp: App {
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
}
