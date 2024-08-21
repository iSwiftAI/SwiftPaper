//
//  CCFStore.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/10/12.
//

import Foundation
import Combine
#if os(iOS)
import AlertKit
#endif

@MainActor
class CCFStore: ObservableObject {
    
    private static var loadDataURL = "https://api.iswiftai.com/swiftpaper/ccf_new.json"
    
    @Published var ccfModels: [CCFModel] = []

    @Published var errorDescription: String?
    @Published var status: loadStatus = .loading
    
    init() {
        self.ccfModels = CCFStore.placeholderCCF
        status = .success
    }
    
    
    func fetch(force: Bool = false) async {
        
        if ccfModels.isEmpty {
            self.status = .loading
        } else {
            self.status = .refreshing
        }
        
        do {
            self.ccfModels = try await loadjsonfromWeb(from: URL(string: Self.loadDataURL)!, force: force)
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
    
    func getCCFModel(deadLine: DeadLine) -> CCFModel? {
        for ccfModel in ccfModels {
            if ccfModel.abbreviation == deadLine.title && ccfModel.form == "会议" {
                return ccfModel
            }
        }
        return nil
    }
    
    
    static var placeholderCCF: [CCFModel] {
        return loadjsonfromFile("ccf.json")
    }
}


enum loadStatus {
    case success
    case fail
    case loading
    case refreshing
}
