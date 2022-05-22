//
//  NetworkDataFetcherTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 19.05.2022.
//
@testable import CountriesApp
import XCTest

final class NetworkDataFetcherTests: XCTestCase {
    
    // MARK: - Private Properties
    private var sut: NetworkDataFetcherProtocol?
    private var networkService: NetworkServiceProtocol!
    private let session = MockURLSession()

    // MARK: - Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()

        networkService = NetworkService(session: session)
        sut = NetworkDataFetcher(networkService: networkService)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testGetCountriesSuccess() {
        let mockJSONData = """
        {
        "next":"https://mockurl",
        "countries":[
        {
        "name": "England",
        "continent": "Eurasia",
        "capital":"London",
        "population" : 123456,
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

        guard let url = URL(string: "https://mockurl") else {
            print("URL can't be empty")
            return
        }
        session.nextData = mockJSONData

        sut?.getCountries(from: url) { countries, next in
            XCTAssertEqual(countries.count, 1)
            XCTAssertEqual(countries.first?.name, "England")
            XCTAssertEqual(countries.first?.population, 123_456)
            XCTAssertNotNil(next)
        }
    }

    func testGetCountriesEmptyData() {
        let mockJSONData = "{}".data(using: .utf8)

        guard let url = URL(string: "https://mockurl") else {
            print("URL can't be empty")
            return
        }
        session.nextData = mockJSONData

        sut?.getCountries(from: url) { countries, next in
            XCTAssertEqual(countries.count, 0)
            XCTAssertNil(next)
        }
    }

    func testGetCountriesFailure() {
        let expectedError = NSError(domain: "Some error", code: 0)

        guard let url = URL(string: "https://mockurl") else {
            print("URL can't be empty")
            return
        }
        session.nextError = expectedError

        sut?.getCountries(from: url) { countries, next in
            XCTAssertEqual(countries.count, 0)
            XCTAssertNil(next)
        }
    }
}
