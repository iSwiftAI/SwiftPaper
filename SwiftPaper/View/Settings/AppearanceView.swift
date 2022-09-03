//
//  AppearanceView.swift
//  SwiftPaper
//
//  Created by Niall Lv on 2022/9/3.
//

import SwiftUI

struct AppearanceView: View {
    
    @AppStorage("isDarkMode") var isDarkMode: Int = 2
    @AppStorage("appTintColor") var appTintColor: Color = .red
    @AppStorage("appIcon") var appIcon: String = "Default"
    
    var body: some View {
        List {
            Section {
                Picker("", selection: $isDarkMode) {
                    Text("跟随系统").tag(2)
                    Text("浅色模式").tag(0)
                    Text("深色模式").tag(1)
                }
                .pickerStyle(.inline)
                .labelsHidden()
                .onChange(of: isDarkMode) { newValue in
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = isDarkMode == 1 ? .dark : isDarkMode == 0 ? .light : .unspecified
                }
                
            } header: {
                Text("主题")
            }
            
            Section {
                Picker("", selection: $appIcon) {
                    HStack {
                        Image("DefaultImage").IconImageStyle(width: 70)
                        Text("Default")
                    }.tag("Default")
                    HStack {
                        Image("GradientImage").IconImageStyle(width: 70)
                        Text("Gradient")
                    }.tag("Gradient")
                    HStack {
                        Image("RedImage").IconImageStyle(width: 70)
                        Text("Red")
                    }.tag("Red")
                    HStack {
                        Image("YelloImage").IconImageStyle(width: 70)
                        Text("Yello")
                    }.tag("Yello")
                    HStack {
                        Image("GreenImage").IconImageStyle(width: 70)
                        Text("Green")
                    }.tag("Green")
                    HStack {
                        Image("OldImage").IconImageStyle(width: 70)
                        Text("Old")
                    }.tag("Old")
                }
                .pickerStyle(.inline)
                .labelsHidden()
                .onChange(of: appIcon) { newValue in
                    if newValue == "Default" {
                        UIApplication.shared.setAlternateIconName(nil)
                    } else {
                        UIApplication.shared.setAlternateIconName(newValue)
                    }
                }
            } header: {
                Text("APP 图标")
            }
            
            
            Section {
                ColorPicker("选择应用的强调色", selection: $appTintColor, supportsOpacity: true)
                    .onChange(of: appTintColor) { newValue in
                        UIApplication.shared.keyWindow?.tintColor = UIColor(appTintColor)
                    }
            } header: {
                Text("强调色")
            }
            
            Button {
                self.isDarkMode = 2
                self.appTintColor = .red
                self.appIcon = "Default"
            } label: {
                Label("恢复默认", systemImage: "arrow.counterclockwise")
            }
        }
        .navigationTitle(Text("外观"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
            .environmentObject(AppThemeViewModel())
    }
}
