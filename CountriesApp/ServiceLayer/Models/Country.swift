//
//  Country.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 04.04.2022.
//

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

    enum CodingKeys: String, CodingKey {
        case name
        case continent
        case capital
        case population
        case descriptionSmall = "description_small"
        case description
        case image
        case countryInfo = "country_info"
    }
}

struct CountryInfo: Decodable {
    let images: [String]
    let flag: String
}
