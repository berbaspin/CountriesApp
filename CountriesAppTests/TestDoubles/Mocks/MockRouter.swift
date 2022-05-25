//
//  MockRouter.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 24.05.2022.
//

@testable import CountriesApp
import Foundation

final class MockRouter: RouterProtocol {

    private(set) var country: CountryViewData?

    func initializeViewController() {}

    func showDetails(country: CountryViewData) {
        self.country = country
    }
}
