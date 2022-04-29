//
//  Country.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 04.04.2022.
//
import Foundation

struct CountriesWrapped: Decodable {
    let next: String
    let countries: [Country]
}

struct Country: Decodable {
    let name: String
    let continent: String
    let capital: String
    let population: Int
    let descriptionSmall: String?
    let description: String
    let image: String
    let countryInfo: CountryInfo
}

extension Country {
    struct CountryInfo: Decodable {
        let images: [String]
        let flag: String
    }
}
