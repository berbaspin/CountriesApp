//
//  CountryInformationTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 20.05.2022.
//

@testable import CountriesApp
import XCTest

final class CountryInformationTests: XCTestCase {

    private var sut: CountryInformation?

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testCapitalReturnsIcon() {
        sut = .capital
        XCTAssertEqual(sut?.icon, "star")
    }

    func testPopulationReturnsIcon() {
        sut = .population
        XCTAssertEqual(sut?.icon, "face.smiling")
    }

    func testContinentReturnsIcon() {
        sut = .continent
        XCTAssertEqual(sut?.icon, "globe.asia.australia")
    }
}
