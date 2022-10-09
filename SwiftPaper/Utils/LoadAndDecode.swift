//
//  LoadAndDecode.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/28.
//
import Foundation


func loadjsonfromWeb<T: Decodable>(from url: URL, force: Bool = false) async throws -> [T] {
    var session = URLSession.shared
    if force {
        let configuration = URLSessionConfiguration.ephemeral
        session = URLSession(configuration: configuration)
    }
    let (data, _) = try await retrying {
        try await session.data(from: url)
    }
    let decoder = JSONDecoder()
    return try decoder.decode([T].self, from: data)
}

func retrying<T>(attempts: Int = 3, delay: TimeInterval = 1, closure: @escaping () async throws -> T) async rethrows -> T {
    for i in 0 ..< attempts - 1 {
        do {
            return try await closure()
        } catch {
            print("第\(i)次尝试，错误为\n\(error)\naaaaaaaaaa")
            let delay = UInt64(delay * TimeInterval(1_000_000_000))
            try await Task.sleep(nanoseconds: delay)
        }
    }
    return try await closure()
}

func loadjsonfromFile<T: Decodable>(_ filename: String) -> [T] {
    var placeholders: [T]
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
        placeholders = try decoder.decode([T].self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename):\n\(error)")
    }
    return placeholders
}


