//
//  Location.swift
//  BucketList
//
//  Created by Izabela Marcinkowska on 2024-11-19.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
