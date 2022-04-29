//
//  CountryInformation.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 28.04.2022.
//

enum CountryInformation: String, CaseIterable {
    case capital
    case population
    case continent
}

extension CountryInformation {
    var icon: String {
        switch self {
        case .capital:
            return "star"
        case .population:
            return "face.smiling"
        case .continent:
            return "globe.asia.australia"
        }
    }
}
