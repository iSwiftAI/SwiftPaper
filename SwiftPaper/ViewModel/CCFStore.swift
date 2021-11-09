//
//  CCFStore.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/10/12.
//

import Foundation
import Combine
import Alamofire

class CCFStore: ObservableObject {
    
    private static var loadDataURL = "https://niallapi.top/app/ccf/ccf.json"
    
    @Published var ccfModels: [CCFModel] = []
    @Published var loading: Bool = true
    
    
    init() {
        self.fetchLatestModelsfromWeb()
        
    }
    
    func fetchLatestModelsfromWeb() {
        self.loading = true
        AF.request(Self.loadDataURL, method: .get)
            .responseDecodable(of: [CCFModel].self) { response in
                switch response.result {
                case .success:
                    
                    self.ccfModels = response.value!
                    self.loading = false
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    func loadjsonfromFile(_ filename: String) {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            self.ccfModels = try decoder.decode([CCFModel].self, from: data)
            self.loading = false
        } catch {
            fatalError("Couldn't parse \(filename):\n\(error)")
        }
    }
    
    static var placeholderCCF: [CCFModel] {
        let ccfStore = CCFStore()
        ccfStore.loadjsonfromFile("ccf.json")
        return ccfStore.ccfModels
    }

    
}
