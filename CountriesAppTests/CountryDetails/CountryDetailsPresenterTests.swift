//
//  CountryDetailsPresenterTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 17.05.2022.
//

@testable import CountriesApp
import XCTest

final class CountryDetailsPresenterTests: XCTestCase {

    private var sut: CountryDetailsPresenter?
    private var viewController: MockCountryDetailsDisplayLogic!
    private var country: CountryViewData?

    override func setUp() {
        super.setUp()

        let countryViewData = CountryViewData.mock
        let detailsViewController = MockCountryDetailsDisplayLogic()
        let detailsPresenter = CountryDetailsPresenter(view: detailsViewController, country: countryViewData)

        sut = detailsPresenter
        viewController = detailsViewController
        country = countryViewData
    }

    override func tearDown() {
        sut = nil
        viewController = nil
        super.tearDown()
    }

    func testGetData() {
        sut?.getData()
        XCTAssertNotNil(viewController.country)
        XCTAssertEqual(country?.name, viewController.country?.name)
        XCTAssertEqual(country?.images, viewController.images)
        XCTAssertTrue(viewController.showPageControl)
    }

}
