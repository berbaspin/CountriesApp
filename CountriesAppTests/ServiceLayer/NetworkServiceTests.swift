//
//  NetworkServiceTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 19.05.2022.
//

@testable import CountriesApp
import XCTest

final class NetworkServiceTests: XCTestCase {

    private var sut: NetworkService?
    private var session: MockURLSession!

    override func setUp() {
        super.setUp()
        let dataTask = MockURLSessionDataTask()
        session = MockURLSession(dataTask: dataTask)
        sut = NetworkService(session: session)
    }

    override func tearDown() {
        session = nil
        sut = nil
        super.tearDown()
    }

    func testRequestWithURL() {
        guard let url = URL(string: "https://mockurl") else {
            XCTFail("URL can't be empty")
            return
        }
        sut?.request(from: url) { _ in }

        XCTAssertEqual(session.lastURL, url)
    }

    func testRequestResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask

        guard let url = URL(string: "https://mockurl") else {
            XCTFail("URL can't be empty")
            return
        }
        sut?.request(from: url) { _ in }

        XCTAssert(dataTask.resumeWasCalled)
    }

    func testRequestReturnedData() {
        let expectedData = "{}".data(using: .utf8)
        guard let url = URL(string: "https://mockurl") else {
            XCTFail("URL can't be empty")
            return
        }
        session.nextData = expectedData

        let expectation = expectation(description: "Request returned data")

        sut?.request(from: url) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }

    func testRequestReturnedFailure() {
        let expectedError = NSError(domain: "Page not found", code: 404)
        guard let url = URL(string: "https://mockurl") else {
            XCTFail("URL can't be empty")
            return
        }
        session.nextError = expectedError

        let expectation = expectation(description: "Request returned Failure")

        sut?.request(from: url) { result in
            switch result {
            case .success(let data):
                XCTFail("Expected to be a failure but got a success with data \(data)")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
