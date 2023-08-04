//
//  CCFStore.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/10/12.
//

import Foundation
import Combine

@MainActor
class CCFStore: ObservableObject {
    
    private static var loadDataURL = "https://api.swiftpaper.top/ccf_new.json"
    
    @Published var ccfModels: [CCFModel] = []

    @Published var errorDescription: String?
    @Published var showIndicator = false
    
    @Published var status: loadStatus = .loading
    
    init() {
        Task {
            await fetch(force: false)
        }
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
        
        showIndicator = true
        try? await Task.sleep(nanoseconds: 10)
        showIndicator = false
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
