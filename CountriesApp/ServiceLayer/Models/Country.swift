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
  internal init(name: String, continent: String, capital: String, population: Int, descriptionSmall: String?, description: String, image: String, countryInfo: Country.CountryInfo) {
    self.name = name
    self.continent = continent
    self.capital = capital
    self.population = population
    self.descriptionSmall = descriptionSmall
    self.description = description
    self.image = image
    self.countryInfo = countryInfo
  }
  
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
