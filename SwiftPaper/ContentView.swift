//
//  ContentView.swift
//  Shared
//
//  Created by 吕丁阳 on 2021/10/2.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("showWelcome") var showWelcome: Bool = true
    
    var body: some View {
        CCFList()
            .navigationViewStyle(.stack)
            .sheet(isPresented: $showWelcome, onDismiss: {}) {
                WelcomeView()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
