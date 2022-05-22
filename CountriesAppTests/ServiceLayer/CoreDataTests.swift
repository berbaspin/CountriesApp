//
//  CoreDataTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 17.05.2022.
//

import CoreData
@testable import CountriesApp
import XCTest

final class CoreDataTests: XCTestCase {
    // MARK: - Properties
    // swiftlint:disable implicitly_unwrapped_optional
    private var coreDataManager: CoreDataManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        coreDataManager = CoreDataManager(persistentStoreDescriptionType: NSInMemoryStoreType)
    }

    override func tearDownWithError() throws {
        coreDataManager = nil
        try super.tearDownWithError()
    }

    func testSaveAndGetCountrySuccess() {
        let countryInfo = Country.CountryInfo(images: [], flag: "some flag")
        let country = Country(
            name: "Foo",
            continent: "Bar",
            capital: "Baz",
            population: 123,
            descriptionSmall: nil,
            description: "some description",
            image: "some image",
            countryInfo: countryInfo
        )
        let images = country.countryInfo.images + [country.image]
        coreDataManager.saveCountry(country: country)

        let getCountry = coreDataManager.getCountries()

        XCTAssertEqual(getCountry.count, 1)

        XCTAssertEqual(getCountry.first?.name, country.name)
        XCTAssertEqual(getCountry.first?.continent, country.continent)
        XCTAssertEqual(getCountry.first?.capital, country.capital)
        XCTAssertEqual(getCountry.first?.longDescription, country.description)
        XCTAssertEqual(getCountry.first?.smallDescription, country.descriptionSmall)
        XCTAssertEqual(getCountry.first?.flag, country.countryInfo.flag)
        XCTAssertEqual(getCountry.first?.images?.count, images.count)
    }
}
