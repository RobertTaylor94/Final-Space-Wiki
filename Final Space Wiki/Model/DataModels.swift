//
//  CharacterDataModel.swift
//  Final Space Wiki
//
//  Created by Robert Taylor on 15/06/2021.
//

import Foundation

struct character: Codable {
    let name: String
    let status: String
    let species: String?
    let gender: String
    let hair: String
    let alias: [String]
    let origin: String
    let img_url: String
    let abilities: [String]?
    
}

struct Location: Codable {
    let name: String
    let type: String
    let inhabitants: [String]
    let notableResidents: [String]?
    let img_url: String
}
