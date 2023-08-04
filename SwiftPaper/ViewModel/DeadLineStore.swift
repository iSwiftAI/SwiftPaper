//
//  DeadLineStore.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/28.
//
import Foundation
import Combine

@MainActor
class DeadLineStore: ObservableObject {
    
    private static var loadDataURL = "https://api.swiftpaper.top/conference_new.json"
    
    @Published var deadLines: [DeadLine] = []

    @Published var errorDescription: String?
    @Published var showIndicator = false
    
    @Published var status: loadStatus = .loading
    
    
    init() {
        Task {
            await fetch(force: false)
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
        
        showIndicator = true
        try? await Task.sleep(nanoseconds: 10)
        showIndicator = false
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
