//
//  MockCountryListDisplayLogic.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 17.05.2022.
//

@testable import CountriesApp
import Foundation

final class MockCountryListDisplayLogic: CountriesListViewProtocol {
    private(set) var isSpinnerHidden = true
    private(set) var countries = [CountryViewData]()
    private(set) var duration: Double?

    func setCountries(_ countries: [CountryViewData], showPagination: Bool, duration: Double) {
        self.countries = countries
        isSpinnerHidden = showPagination
        self.duration = duration
    }
}
