//
//  Rocket.swift
//  RocketsAPI
//
//  Created by AutoMendes on 29/05/2025.
//

// Rocket.swift

import Foundation

struct Rocket: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let flickr_images: [String]
}
