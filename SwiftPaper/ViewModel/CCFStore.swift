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
    
    private static var loadDataURL = "https://niallapi.top/app/ccf/ccf.json"
    
    @Published var ccfModels: [CCFModel] = []
    @Published var loading: Bool = true
    @Published var refreshing: Bool = false
    
    @Published var successfullyLoaded: Bool = true
    @Published var errorDescription: String?
    @Published var showIndicator = false
    
    init() {
        Task {
            await fetch(force: false)
        }
    }
    
    
    func fetch(force: Bool = false) async {
        
        if ccfModels.isEmpty {
            self.loading = true
        }
        self.refreshing = true
        do {
            self.ccfModels = try await loadjsonfromWeb(from: URL(string: Self.loadDataURL)!, force: force)
            successfullyLoaded = true
            errorDescription = nil
        } catch {
            successfullyLoaded = false
            errorDescription = error.localizedDescription
        }
        self.loading = false
        self.refreshing = false
        
        showIndicator = true
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
