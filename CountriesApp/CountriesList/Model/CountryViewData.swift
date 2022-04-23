//
//  CountryViewData.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import Foundation

struct CountryViewData {

    var name: String
    var capital: String
    var population: String
    var continent: String
    var description: String
    var shortDescription: String
    var flag: String
    var images: [String]

}

extension CountryViewData: Equatable {
    static func == (lhs: CountryViewData, rhs: CountryViewData) -> Bool {
        lhs.name == rhs.name
    }
}
