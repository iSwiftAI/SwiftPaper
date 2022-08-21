//
//  RateApp.swift
//  SwiftPaper (iOS)
//
//  Created by 吕丁阳 on 2021/11/9.
//

import Foundation

import StoreKit

func rateApp() {
    let appID = "1640972298"
    let urlStr = "https://itunes.apple.com/app/id\(appID)?action=write-review"
    
    guard let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) else { return }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
}
