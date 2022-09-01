//
//  LoadUpdateTime.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/30.
//

import Foundation

func loadUpdateTime(from url: URL, force: Bool = false) async throws -> String {
    var session = URLSession.shared
    if force {
        let configuration = URLSessionConfiguration.ephemeral
        session = URLSession(configuration: configuration)
    }
    let (data, _) = try await session.data(from: url)

    return String(decoding: data, as: UTF8.self)
}
