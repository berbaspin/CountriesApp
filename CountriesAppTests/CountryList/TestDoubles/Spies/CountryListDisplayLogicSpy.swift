//
//  CountryListDisplayLogicSpy.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 17.05.2022.
//

@testable import CountriesApp
import Foundation

final class CountryListDisplayLogicSpy: CountriesListViewProtocol {

    // MARK: - Private Propeties
    private(set) var isSpinnerHidden = true
    private(set) var countries = [CountryViewData]()

    // MARK: - Public Methods

    func setCountries(_ countries: [CountryViewData], showPagination: Bool) {
        self.countries = countries
        isSpinnerHidden = showPagination
    }

}
