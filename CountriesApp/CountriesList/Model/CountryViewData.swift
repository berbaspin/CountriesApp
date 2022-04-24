//
//  CountryViewData.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import Foundation

struct CountryViewData {

    let name: String
    var capital: String
    var population: String
    var continent: String
    var description: String
    var shortDescription: String
    var flag: String
    var images: [String]

}

// MARk
extension CountryViewData: Equatable {
}
