//
//  Country.swift
//  Day59Challenge
//
//  Created by BERAT ALTUNTAŞ on 4.03.2022.
//

import UIKit
import Foundation

struct Country: Decodable {
    let name: String
    let alpha2Code: String
    let callingCodes: [String]
    let capital: String?
    let altSpellings: [String]?
    let subregion: String
    let region: Region
    let population: Int
    let latlng: [Double]?
    let demonym: String
    let area: Double?
    let timezones: [String]
    let nativeName, numericCode: String
    let flags: Flags
    let currencies: [Currency]?
    let languages: [Language]
    let flag: String
    let regionalBlocs: [RegionalBloc]?
    let cioc: String?
    let independent: Bool
    let gini: Double?
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
    let iso6391: String?
    let iso6392, name: String
    let nativeName: String?
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name, nativeName
    }
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case antarcticOcean = "Antarctic Ocean"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
    case polar = "Polar"
}

// MARK: - RegionalBloc
struct RegionalBloc: Codable {
    let acronym: Acronym
    let name: Name
    let otherNames: [OtherName]?
    let otherAcronyms: [OtherAcronym]?
}

enum Acronym: String, Codable {
    case al = "AL"
    case asean = "ASEAN"
    case au = "AU"
    case cais = "CAIS"
    case caricom = "CARICOM"
    case cefta = "CEFTA"
    case eeu = "EEU"
    case efta = "EFTA"
    case eu = "EU"
    case nafta = "NAFTA"
    case pa = "PA"
    case saarc = "SAARC"
    case usan = "USAN"
}

enum Name: String, Codable {
    case africanUnion = "African Union"
    case arabLeague = "Arab League"
    case associationOfSoutheastAsianNations = "Association of Southeast Asian Nations"
    case caribbeanCommunity = "Caribbean Community"
    case centralAmericanIntegrationSystem = "Central American Integration System"
    case centralEuropeanFreeTradeAgreement = "Central European Free Trade Agreement"
    case eurasianEconomicUnion = "Eurasian Economic Union"
    case europeanFreeTradeAssociation = "European Free Trade Association"
    case europeanUnion = "European Union"
    case northAmericanFreeTradeAgreement = "North American Free Trade Agreement"
    case pacificAlliance = "Pacific Alliance"
    case southAsianAssociationForRegionalCooperation = "South Asian Association for Regional Cooperation"
    case unionOfSouthAmericanNations = "Union of South American Nations"
}

enum OtherAcronym: String, Codable {
    case eaeu = "EAEU"
    case sica = "SICA"
    case unasul = "UNASUL"
    case unasur = "UNASUR"
    case uzan = "UZAN"
}

enum OtherName: String, Codable {
    case accordDeLibreÉchangeNordAméricain = "Accord de Libre-échange Nord-Américain"
    case alianzaDelPacífico = "Alianza del Pacífico"
    case caribischeGemeenschap = "Caribische Gemeenschap"
    case communautéCaribéenne = "Communauté Caribéenne"
    case comunidadDelCaribe = "Comunidad del Caribe"
    case jāmiAtAdDuwalAlArabīyah = "Jāmiʻat ad-Duwal al-ʻArabīyah"
    case leagueOfArabStates = "League of Arab States"
    case sistemaDeLaIntegraciónCentroamericana = "Sistema de la Integración Centroamericana,"
    case southAmericanUnion = "South American Union"
    case tratadoDeLibreComercioDeAméricaDelNorte = "Tratado de Libre Comercio de América del Norte"
    case umojaWaAfrika = "Umoja wa Afrika"
    case unieVanZuidAmerikaanseNaties = "Unie van Zuid-Amerikaanse Naties"
    case unionAfricaine = "Union africaine"
    case uniãoAfricana = "União Africana"
    case uniãoDeNaçõesSulAmericanas = "União de Nações Sul-Americanas"
    case uniónAfricana = "Unión Africana"
    case uniónDeNacionesSuramericanas = "Unión de Naciones Suramericanas"
    case الاتحادالأفريقي = "الاتحاد الأفريقي"
    case جامعةالدولالعربية = "جامعة الدول العربية"
}

// MARK: - Translations
struct Translations: Codable {
    let br, pt, nl, hr: String
    let fa: String?
    let de, es, fr, ja: String
    let it, hu: String
}

typealias Welcome = [Country]
