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
    
    
    func fetch(force: Bool = false) async {
        if ccfModels.isEmpty {
            self.loading = true
            do {
                self.ccfModels = try await loadjsonfromWeb(from: URL(string: Self.loadDataURL)!, force: force)
            } catch {
                print(error)
            }
            self.loading = false
        }
        
    }
    
    func getCCFModel(deadLine: DeadLine) -> CCFModel? {
        for ccfModel in ccfModels {
            if ccfModel.abbreviation == deadLine.title {
                return ccfModel
            }
        }
        print(deadLine.title)
        return nil
    }
    
    
    static var placeholderCCF: [CCFModel] {
        return loadjsonfromFile("ccf.json")
    }
}
