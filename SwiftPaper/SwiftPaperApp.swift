//
//  SwiftPaperApp.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/9.
//

import SwiftUI

@main
struct SwiftPaperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
#if os(macOS)
        .defaultSize(width: 1200, height: 800)
        .defaultPosition(.center)
#endif
    }
}
