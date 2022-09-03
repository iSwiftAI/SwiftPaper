//
//  ModeToggle.swift
//  SwiftPaper
//
//  Created by Niall Lv on 2022/9/3.
//

import Foundation
import SwiftUI
import UIKit

class AppThemeViewModel: ObservableObject {
    
    @AppStorage("isDarkMode") var isDarkMode: Int = 2
    @AppStorage("appTintColor") var appTintColor: Color = .red
    
}

extension Color: RawRepresentable {

    public init?(rawValue: String) {
        guard let data = Data(base64Encoded: rawValue) else {
            self = .black
            return
        }
        do {
            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .black
            self = Color(color)
        } catch {
            self = .black
        }
    }

    public var rawValue: String {
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()
        } catch {
            return ""
        }
    }
}
