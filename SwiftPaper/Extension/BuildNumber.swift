//
//  BuildNumber.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/29.
//

import Foundation

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
