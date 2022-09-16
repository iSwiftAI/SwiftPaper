//
//  ContentView.swift
//  Shared
//
//  Created by 吕丁阳 on 2021/10/2.
//

import SwiftUI

struct ContentView: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    
    @AppStorage("showWelcome") var showWelcome: Bool = true
    
    @StateObject var ccfStore = CCFStore()
    @StateObject var deadLineStore = DeadLineStore()
    
    var body: some View {
        Group {
            #if os(iOS)
                if horizontalSizeClass == .compact {
                    AppTabNavigation()
                } else {
                    AppSidebarNavigation()
                }
            #else
                AppSidebarNavigation()
            #endif
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
