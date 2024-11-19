//
//  Result.swift
//  BucketList
//
//  Created by Izabela Marcinkowska on 2024-11-19.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
