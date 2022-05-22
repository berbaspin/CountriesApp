//
//  CountryTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 16.05.2022.
//

@testable import CountriesApp
import XCTest

class CountryTests: XCTestCase {

    // MARK: - Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testInitCountryWithAllProperties() {
        let countryInfo = Country.CountryInfo(images: [], flag: "Foo")
        let sut = Country(
            name: "Foo",
            continent: "Bar",
            capital: "Baz",
            population: 123,
            descriptionSmall: "Some small description",
            description: "Some description",
            image: "Some url string",
            countryInfo: countryInfo
        )
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.name, "Foo")
        XCTAssertEqual(sut.continent, "Bar")
        XCTAssertEqual(sut.capital, "Baz")
        XCTAssertEqual(sut.population, 123)
        XCTAssertNotNil(sut.descriptionSmall)
        XCTAssertEqual(sut.descriptionSmall, "Some small description")
        XCTAssertEqual(sut.description, "Some description")
        XCTAssertEqual(sut.image, "Some url string")
        XCTAssertEqual(sut.countryInfo.flag, "Foo")
        XCTAssertEqual(sut.countryInfo.images.count, 0)
    }

}
