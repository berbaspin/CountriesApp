//
//  ImageManagerTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 24.05.2022.
//

@testable import CountriesApp
import XCTest

final class ImageManagerTests: XCTestCase {

    private var sut: ImageManagerProtocol?
    private var session: MockURLSession!

    override func setUp() {
        super.setUp()
        let dataTask = MockURLSessionDataTask()
        session = MockURLSession(dataTask: dataTask)
        sut = ImageManager(session: session)
    }

    override func tearDown() {
        session = nil
        sut = nil
        super.tearDown()
    }

    func testGetImageSuccess() {
        let expectedData = "{}".data(using: .utf8)
        guard let url = URL(string: "https://mockurl") else {
            XCTFail("URL can't be empty")
            return
        }
        session.nextData = expectedData

        let expectation = expectation(description: "Get image success")

        let imageDataTask = sut?.getImage(from: url) { data, response, _ in
            XCTAssertNotNil(data)
            XCTAssertEqual(url, response?.url)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(imageDataTask)
    }

    func testGetImageFailure() {
        let expectedError = NSError(domain: "Page not found", code: 404)
        guard let url = URL(string: "https://mockurl") else {
            XCTFail("URL can't be empty")
            return
        }
        session.nextError = expectedError

        let expectation = expectation(description: "Get image success")

        _ = sut?.getImage(from: url) { _, _, error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }

}
