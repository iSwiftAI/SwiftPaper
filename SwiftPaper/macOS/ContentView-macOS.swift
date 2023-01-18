//
//  ContentView-macOS.swift
//  SwiftPaper
//
//  Created by Niall Lv on 2023/1/7.
//

import SwiftUI

struct ContentView_macOS: View {
    @AppStorage("showWelcome") var showWelcome: Bool = true
    
    @StateObject var ccfStore = CCFStore()
    @StateObject var deadLineStore = DeadLineStore()
    
    var body: some View {
        Group {
            AppSidebarNavigation()
        }
        .sheet(isPresented: $showWelcome, onDismiss: { Task {
            if self.ccfStore.ccfModels.isEmpty {
                await self.ccfStore.fetch(force: true)
            }
            if self.deadLineStore.deadLines.isEmpty {
                await self.deadLineStore.fetch(force: true)
            }
        } }) {
            WelcomeView()
        }
        .environmentObject(ccfStore)
        .environmentObject(deadLineStore)
    }
}

struct ContentView_macOS_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_macOS()
    }
}
