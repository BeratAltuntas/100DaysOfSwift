//
//  Country.swift
//  Day59Challenge
//
//  Created by BERAT ALTUNTAŞ on 4.03.2022.
//

import UIKit
import Foundation

struct Country: Codable {
    let name: String
    let topLevelDomain: [String]
    let alpha2Code, alpha3Code: String
    let callingCodes: [String]
    let capital: String
    let altSpellings: [String]
    let subregion, region: String
    let population: Int
    let latlng: [Int]
    let demonym: String
    let area: Int
    let gini: Double
    let timezones: [String]
    let nativeName, numericCode: String
    let flags: Flags
    let currencies: [Currency]
    let languages: [Language]
    let flag: String
    let cioc: String
    let independent: Bool
}

// MARK: - Currency
struct Currency: Codable {
    let code, name, symbol: String
}

// MARK: - Flags
struct Flags: Codable {
    let svg: String
    let png: String
}

// MARK: - Language
struct Language: Codable {
    let iso6391, iso6392, name, nativeName: String
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name, nativeName
    }
}

typealias Welcome = [Country]


