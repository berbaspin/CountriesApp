//
//  CountryViewData.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 24.05.2022.
//

@testable import CountriesApp
import Foundation

extension CountryViewData {
    static let mock = CountryViewData(
        name: "Foo",
        capital: "Bar",
        population: "Baz",
        continent: "some continent",
        description: "some description",
        shortDescription: "some shortDescription",
        flag: "some flag",
        images: ["https://mockurl1", "https://mockurl2"]
    )
}
