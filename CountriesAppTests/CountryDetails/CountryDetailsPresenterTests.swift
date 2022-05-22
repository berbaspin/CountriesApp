//
//  CountryDetailsPresenterTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 17.05.2022.
//

@testable import CountriesApp
import XCTest

final class CountryDetailsPresenterTests: XCTestCase {

    // MARK: - Private Properties
    private var sut: CountryDetailsPresenter?
    private var viewController: CountryDetailsDisplayLogicSpy!
    private var country: CountryViewData?

    // MARK: - Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()

        let countryViewData = CountryViewData(
            name: "Foo",
            capital: "Bar",
            population: "Baz",
            continent: "some continent",
            description: "some description",
            shortDescription: "some shortDescription",
            flag: "some flag",
            images: ["https://mockurl1", "https://mockurl2"]
        )
        let detailsViewController = CountryDetailsDisplayLogicSpy()
        let detailsPresenter = CountryDetailsPresenter(view: detailsViewController, country: countryViewData)

        sut = detailsPresenter
        viewController = detailsViewController
        country = countryViewData
    }

    override func tearDownWithError() throws {
        sut = nil
        viewController = nil
        try super.tearDownWithError()
    }

    func testGetData() {
        sut?.getData()
        XCTAssertNotNil(viewController.country)
        XCTAssertEqual(country?.name, viewController.country?.name)
        XCTAssertEqual(country?.images, viewController.images)
        XCTAssertTrue(viewController.showPageControl)
    }

}
