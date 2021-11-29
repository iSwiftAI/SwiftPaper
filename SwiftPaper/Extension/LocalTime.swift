//
//  LocalTime.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/29.
//

import Foundation

extension String {
    func localTime(timeZone: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        if let date = dateFormatter.date(from: self) {
            dateFormatter.timeZone = .current
            let timezone = dateFormatter.timeZone.localizedName(for: .standard, locale: .current)
            return dateFormatter.string(from: date) + "\n" + timezone!
        }
        return "暂无时间"
    }
}
