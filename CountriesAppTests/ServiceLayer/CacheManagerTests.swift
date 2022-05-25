//
//  CacheManagerTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 24.05.2022.
//

@testable import CountriesApp
import XCTest

final class CacheManagerTests: XCTestCase {

    private var sut: CacheManagerProtocol?

    override func setUp() {
        super.setUp()
        sut = CacheManager()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSaveAndGetData() {
        guard let url = URL(string: "https://mockurl") else {
            print("URL can't be empty")
            return
        }
        let expectedData = "{}".data(using: .utf8)!
        let expectedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!

        sut?.saveData(with: expectedData, response: expectedResponse)
        let returnedData = sut?.getData(for: url)

        XCTAssertNotNil(returnedData)
        XCTAssertEqual(returnedData, expectedData)
    }
}
