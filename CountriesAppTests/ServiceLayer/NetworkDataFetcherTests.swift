//
//  NetworkDataFetcherTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 19.05.2022.
//
@testable import CountriesApp
import XCTest

final class NetworkDataFetcherTests: XCTestCase {

    private var sut: NetworkDataFetcherProtocol?
    private var networkService: NetworkServiceProtocol!
    private var session: MockURLSession!
    private var jsonLoader: LocalJSONLoader!

    override func setUp() {
        super.setUp()
        let dataTask = MockURLSessionDataTask()
        session = MockURLSession(dataTask: dataTask)
        networkService = NetworkService(session: session)
        jsonLoader = LocalJSONLoader()
        sut = NetworkDataFetcher(networkService: networkService)
    }

    override func tearDown() {
        session = nil
        networkService = nil
        jsonLoader = nil
        sut = nil
        super.tearDown()
    }

    func testGetCountriesSuccess() {
        let mockFileName = "MockJSONData"
        let mockJSONData = jsonLoader.load(filename: mockFileName)

        guard let url = URL(string: "https://mockurl") else {
            XCTFail("URL can't be empty")
            return
        }
        session.nextData = mockJSONData

        let expectation = expectation(description: "Get countries success")

        sut?.getCountries(from: url) { countries, next, _ in
            XCTAssertEqual(countries.count, 1)
            XCTAssertEqual(countries.first?.name, "England")
            XCTAssertEqual(countries.first?.population, 123_456)
            XCTAssertNotNil(next)

            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }

    func testGetCountriesEmptyData() {
        let mockJSONData = "{}".data(using: .utf8)

        guard let url = URL(string: "https://mockurl") else {
            XCTFail("URL can't be empty")
            return
        }
        session.nextData = mockJSONData

        let expectation = expectation(description: "Get countries empty data")

        sut?.getCountries(from: url) { countries, next, _ in
            XCTAssertEqual(countries.count, 0)
            XCTAssertNil(next)

            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testGetCountriesFailure() {
        let expectedError = NSError(domain: "Some error", code: 0)

        guard let url = URL(string: "https://mockurl") else {
            XCTFail("URL can't be empty")
            return
        }
        session.nextError = expectedError

        let expectation = expectation(description: "Get contries failure")

        sut?.getCountries(from: url) { _, _, error in
            XCTAssertNotNil(error)

            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}
