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

    private var sut: CountriesListPresenter?
    private var viewController: MockCountryListDisplayLogic!
    private var router: MockRouter!
    private var networkDataFetcher: NetworkDataFetcherProtocol!
    private var networkService: NetworkServiceProtocol!
    private var session: MockURLSession!

    override func setUp() {
        super.setUp()

        viewController = MockCountryListDisplayLogic()
        router = MockRouter()
        let dataTask = MockURLSessionDataTask()
        session = MockURLSession(dataTask: dataTask)
        networkService = NetworkService(session: session)
        networkDataFetcher = NetworkDataFetcher(networkService: networkService)
        let coreDataManager = CoreDataManager(persistentStoreDescriptionType: NSInMemoryStoreType)
        sut = CountriesListPresenter(
            view: viewController,
            networkDataFetcher: networkDataFetcher,
            coreDataManager: coreDataManager,
            router: router
        )
    }

    override func tearDown() {
        viewController = nil
        session = nil
        router = nil
        sut = nil

        super.tearDown()
    }

    func testGetLatestCountries() {
        let mockJSONData = """
        {
        "next":"https://mockurl",
        "countries":[
        {
        "name": "Абхазия",
        "continent": "Eurasia",
        "capital":"Сухум",
        "population" : 243564 ,
        "description_small": "some small description",
        "description": "some description",
        "image": "https://mockurl",
        "country_info": {
            "images":[],
            "flag": "https://mockurl"
        }
        }
        ]
        }
        """.data(using: .utf8)
        session.nextData = mockJSONData

        sut?.getLatestCountries()

        XCTAssertNotNil(session.lastURL)
        XCTAssertEqual(viewController.countries.count, 1)
    }

    func testGetMoreCountries() {
        let mockJSONData = """
        {
        "next":"https://mockurl",
        "countries":[
        {
        "name": "Абхазия",
        "continent": "Eurasia",
        "capital":"Сухум",
        "population" : 243564 ,
        "description_small": "some small description",
        "description": "some description",
        "image": "https://mockurl",
        "country_info": {
            "images":[],
            "flag": "https://mockurl"
        }
        }
        ]
        }
        """.data(using: .utf8)
        session.nextData = mockJSONData

        sut?.getMoreCountries()

        XCTAssertNotNil(session.lastURL)
        XCTAssertEqual(viewController.countries.count, 1)
    }

    func testTapOnCountry() {
        let country = CountryViewData.mock

        sut?.tapOnCountry(country: country)
        XCTAssertEqual(country.name, router.country?.name)
    }
}
