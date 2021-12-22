//
//  Cast.swift
//  BeersJson
//
//  Created by 노건호 on 2021/12/22.
//

import Foundation

// MARK: - Beer
struct Beer: Codable {
    let name, tagline, beerDescription, imageURL: String
    let foodPairing: [String]

    enum CodingKeys: String, CodingKey {
        case name, tagline
        case beerDescription = "description"
        case imageURL = "image_url"
        case foodPairing = "food_pairing"
    }
}
