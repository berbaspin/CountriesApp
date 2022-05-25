//
//  CoreDataManagerTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 17.05.2022.
//

import CoreData
@testable import CountriesApp
import XCTest

final class CoreDataManagerTests: XCTestCase {

    // swiftlint:disable implicitly_unwrapped_optional
    private var coreDataManager: CoreDataManager!

    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager(persistentStoreDescriptionType: NSInMemoryStoreType)
    }

    override func tearDown() {
        coreDataManager = nil
        super.tearDown()
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

    func testSaveDataWithoutDuplicates() {
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

        coreDataManager.saveCountry(country: country)
        coreDataManager.saveCountry(country: country)

        let getCountry = coreDataManager.getCountries()

        XCTAssertEqual(getCountry.count, 1)
    }
}
