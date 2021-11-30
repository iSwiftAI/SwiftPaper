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
        
        private enum CodingKeys: String, CodingKey {
            case year
            case id
            case link
            case timeline
            case timezone
            case date
            case place
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            year = try container.decode(Int.self, forKey: .year)
            id = try container.decode(String.self, forKey: .id)
            link = try container.decode(URL.self, forKey: .link)
            timeline = try container.decode([Timeline].self, forKey: .timeline)
            timezone = try container.decode(String.self, forKey: .timezone)
            date = try container.decode(String.self, forKey: .date)
            place = try container.decode(String.self, forKey: .place)
            
            var deadLineTimes: [Date] = []
            for timeLine in timeline {
                deadLineTimes.append(timeLine.deadline.localdate(timeZone: timezone))
            }
            deadLineTimes = deadLineTimes.sorted(by: <)
            if let neareastDeadLine = deadLineTimes.first(where: {$0.timeIntervalSinceNow > 0}) {
                nearestDeadLineDate = neareastDeadLine
            } else {
                nearestDeadLineDate = deadLineTimes.last!
            }
        }
        
        var nearestDeadLine: DeadLine.Conf.Timeline {
            var deadLines: [DeadLine.Conf.Timeline] = []
            for timeLine in timeline {
                deadLines.append(timeLine)
            }
            deadLines = deadLines.sorted {
                $0.deadline.localdate(timeZone: timezone) < $1.deadline.localdate(timeZone: timezone)
            }
            if let neareastDeadLine = deadLines.first(where: {$0.deadline.localdate(timeZone: timezone).timeIntervalSinceNow > 0}) {
                return neareastDeadLine
            }
            return deadLines.last!
        }
        var nearestDeadLineDate: Date
    }
    
    let title: String
    let description: String
    let sub: String
    let rank: String
    let dblp: String
    let confs: [Conf]
    
    var id: String {
        return title + description
    }
    
    var latestConf: Conf {
        let sortedConfs = confs.sorted { $0.year > $1.year }
        return sortedConfs[0]
    }
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



