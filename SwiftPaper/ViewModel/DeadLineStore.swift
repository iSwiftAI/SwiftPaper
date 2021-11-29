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
    
    private static var loadDataURL = "https://niallapi.top/app/ccf/conference/all.json"
    
    @Published var deadLines: [DeadLine] = []
    @Published var loading: Bool = true
    
    
    func fetch(force: Bool = false) async {
        print(Date())
        if deadLines.isEmpty {
            self.loading = true
        }
        do {
            self.deadLines = try await loadjsonfromWeb(from: URL(string: Self.loadDataURL)!, force: force)
        } catch {
            print(error)
        }
        self.loading = false
        print(Date())
    }
    
    func getDeadLine(ccfModel: CCFModel) -> DeadLine? {
        for deadLine in deadLines {
            if deadLine.title == ccfModel.abbreviation {
                return deadLine
            }
        }
        return nil
    }
    
    static var placeholderCCF: [DeadLine] {
        return loadjsonfromFile("all.json")
    }
}
