//
//  String+Localization.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 14.04.2022.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
