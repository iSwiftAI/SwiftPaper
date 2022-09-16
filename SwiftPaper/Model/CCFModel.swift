//
//  CCFModel.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/10/12.
//

import Foundation

struct CCFModel: Identifiable, Hashable {
    static func == (lhs: CCFModel, rhs: CCFModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var region: String
    var form: String
    var field: String
    var rank: String
    var abbreviation: String
    var fullName: String
    var press: String
    var site: String
    
    // other atrributes
    var url: URL { URL(string: site)! }
    
    // DeadLine
    var deadLine: DeadLine?
    var id: String {
        return fullName + abbreviation + field
    }
}
extension CCFModel: Codable {
    enum CodingKeys: String, CodingKey {
        case region = "Region"
        case form = "Form"
        case field = "Field"
        case rank = "Rank"
        case abbreviation = "Abbreviation"
        case fullName = "FullName"
        case press = "Press"
        case site = "Site"

    }
}
