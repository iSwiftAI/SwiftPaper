//
//  DeadLineStore.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/28.
//
import Foundation
import Combine
#if os(iOS)
import AlertKit
#endif

@MainActor
class DeadLineStore: ObservableObject {
    
    private static var loadDataURL = "https://api.iswiftai.com/swiftpaper/conference_new2.json"
    
    @Published var deadLines: [DeadLine] = []

    @Published var errorDescription: String?
    @Published var status: loadStatus = .loading
    
    
    init() {
        Task {
            await fetch(force: true)
        }
    }

    
    func fetch(force: Bool = false) async {
        
        if deadLines.isEmpty {
            self.status = .loading
        } else {
            self.status = .refreshing
        }
        do {
            self.deadLines = try await loadjsonfromWeb(from: URL(string: Self.loadDataURL)!, force: force)
            sort()
            self.status = .success
            errorDescription = nil
        } catch {
            self.status = .fail
            errorDescription = error.localizedDescription
        }
#if canImport(AlertKit) && os(iOS)
        AlertKitAPI.present(
            title: self.status == .success ? String(localized: "更新成功") : String(localized: "更新失败"),
            icon: self.status == .success ? .done : .error,
            style: .iOS17AppleMusic,
            haptic: self.status == .success ? .success : .error
        )
#endif
    }
    
    func getDeadLine(ccfModel: CCFModel) -> DeadLine? {
        for deadLine in deadLines {
            if deadLine.title == ccfModel.abbreviation {
                return deadLine
            }
        }
        return nil
    }
    
    func sort() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        
        let nowDate = Date()
        var times = 0
        self.deadLines = deadLines.sorted {
            times += 1
            let date1 = $0.latestConf.nearestDeadLineDate
            let date2 = $1.latestConf.nearestDeadLineDate
            if date1 > nowDate && date2 <= nowDate { return true }
            else if date1 > nowDate && date2 > nowDate && date1 < date2 { return true }
            else if date1 <= nowDate && date2 <= nowDate && date1 > date2 { return true }
            else { return false }
        }
    }
    
    static var placeholderCCF: [DeadLine] {
        return loadjsonfromFile("all.json")
    }
}
