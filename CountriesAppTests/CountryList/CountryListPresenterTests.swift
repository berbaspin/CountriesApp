//
//  CountryListPresenterTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 17.05.2022.
//

import CoreData
@testable import CountriesApp
import XCTest

final class CountryListPresenterTests: XCTestCase {

    // MARK: - Private Properties

    private var sut: CountriesListPresenter?
    private var viewController: CountriesListViewProtocol!
    private var router: RouterSpy!
    private var networkDataFetcher: NetworkDataFetcherProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()

        viewController = CountryListDisplayLogicSpy()
        router = RouterSpy()
        let networkService = NetworkService(session: MockURLSession())
        networkDataFetcher = NetworkDataFetcher(networkService: networkService)
        let coreDataManager = CoreDataManager(persistentStoreDescriptionType: NSInMemoryStoreType)
        sut = CountriesListPresenter(view: viewController, networkDataFetcher: networkDataFetcher, coreDataManager: coreDataManager, router: router)
    }

    override func tearDownWithError() throws {
        sut = nil
        viewController = nil

        try super.tearDownWithError()
    }

    func testTapOnCountry() {
        let country = CountryViewData(
            name: "Foo",
            capital: "Bar",
            population: "Baz",
            continent: "some continent",
            description: "some description",
            shortDescription: "some shortDescription",
            flag: "some flag",
            images: ["https://mockurl1", "https://mockurl2"]
        )

        sut?.tapOnCountry(country: country)
        XCTAssertEqual(country.name, router.country?.name)
    }
}

final class RouterSpy: RouterProtocol {

    private(set) var country: CountryViewData?

    func initializeViewController() {

    }

    func showDetails(country: CountryViewData) {
        self.country = country
    }

}
