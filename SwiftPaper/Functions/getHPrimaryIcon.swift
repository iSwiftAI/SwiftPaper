//
//  getHPrimaryIcon.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/29.
//

import Foundation


func getHPrimaryIconName() -> String? {
    guard let infoPlist = Bundle.main.infoDictionary else { return nil }
    guard let bundleIcons = infoPlist["CFBundleIcons"] as? NSDictionary else { return nil }
    guard let bundlePrimaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? NSDictionary else { return nil }
    guard let bundleIconFiles = bundlePrimaryIcon["CFBundleIconFiles"] as? NSArray else { return nil }
    guard let appIcon = bundleIconFiles.lastObject as? String else { return nil }
    return appIcon
}
