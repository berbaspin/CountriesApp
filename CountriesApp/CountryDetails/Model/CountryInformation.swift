//
//  CountryInformation.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 25.05.2022.
//

import Foundation

struct CountryInformation {
    var type: CountryInformationType
    var text: String
}

extension CountryInformation {
    enum CountryInformationType: String {
        case capital
        case population
        case continent

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
}
