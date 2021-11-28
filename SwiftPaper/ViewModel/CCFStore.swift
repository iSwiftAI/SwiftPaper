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
    
    
    func fetch() async {
        if ccfModels.isEmpty {
            self.loading = true
            do {
                self.ccfModels = try await loadjsonfromWeb(from: URL(string: Self.loadDataURL)!)
            } catch {
                print(error)
            }
            self.loading = false
        }
        
    }
    
    
    static var placeholderCCF: [CCFModel] {
        return loadjsonfromFile("ccf.json")
    }
}
