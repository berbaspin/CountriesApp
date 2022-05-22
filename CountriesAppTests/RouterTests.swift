//
//  RouterTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 19.05.2022.
//

@testable import CountriesApp
import XCTest

final class RouterTests: XCTestCase {

    private var sut: RouterProtocol?
    private let navigationController = MockNavigationController()
    private let assemblyBuilder = AssenlyBuilder()

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testRouter() {
        let country = CountryViewData(
            name: "Foo",
            capital: "Bar",
            population: "123",
            continent: "Baz",
            description: "some description",
            shortDescription: "some shortDescription",
            flag: "some flag",
            images: []
        )
        sut?.showDetails(country: country)
        let detailsViewController = navigationController.presenterVC
        XCTAssertTrue(detailsViewController is CountryDetailsViewController)
    }

}
