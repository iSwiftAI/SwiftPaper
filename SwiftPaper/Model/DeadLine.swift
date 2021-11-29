//
//  Deadline.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/28.
//

import Foundation

struct DeadLine: Identifiable {
    struct Conf: Codable, Hashable {
        struct Timeline: Codable, Hashable {
            let abstractDeadline: String?
            let deadline: String
            let comment: String?
            
            private enum CodingKeys: String, CodingKey {
                case abstractDeadline = "abstract_deadline"
                case deadline
                case comment
            }
        }
        
        let year: Int
        let id: String
        let link: URL
        let timeline: [Timeline]
        let timezone: String
        let date: String
        let place: String
    }
    
    let title: String
    let description: String
    let sub: String
    let rank: String
    let dblp: String
    let confs: [Conf]
    
    var id = UUID()
}

extension DeadLine: Codable {
    enum CodingKeys: String, CodingKey {
        case confs = "confs"
        case dblp = "dblp"
        case rank = "rank"
        case title = "title"
        case description = "description"
        case sub = "sub"
    }
}



