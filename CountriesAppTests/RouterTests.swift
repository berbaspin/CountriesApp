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
    private var navigationController: MockNavigationController!
    private var assemblyBuilder: AssemblyBuilderProtocol!

    override func setUp() {
        super.setUp()

        assemblyBuilder = AsseblyBuilder()
        navigationController = MockNavigationController()
        sut = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
    }

    override func tearDown() {
        assemblyBuilder = nil
        sut = nil
        super.tearDown()
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
