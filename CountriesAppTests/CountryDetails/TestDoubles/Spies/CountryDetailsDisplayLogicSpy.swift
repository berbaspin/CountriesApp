//
//  CountryDetailsPresenterSpy.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 17.05.2022.
//

@testable import CountriesApp
import Foundation

final class CountryDetailsDisplayLogicSpy: CountryDetailViewProtocol {

    private(set) var country: CountryViewData?
    private(set) var images = [String]()
    private(set) var showPageControl = false

    func setData(country: CountryViewData, images: [String], showPageControl: Bool) {
        self.images = images
        self.country = country
        self.showPageControl = showPageControl
    }
}
