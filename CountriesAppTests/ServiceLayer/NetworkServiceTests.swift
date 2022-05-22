//
//  NetworkServiceTests.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 19.05.2022.
//

@testable import CountriesApp
import XCTest

final class NetworkServiceTests: XCTestCase {
    
    // MARK: - Private Properties
    private var sut: NetworkService?
    private let session = MockURLSession()

    // MARK: - Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkService(session: session)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testRequestWithURL() {
        guard let url = URL(string: "https://mockurl") else {
            print("URL can't be empty")
            return
        }
        sut?.request(from: url) { _ in }

        XCTAssertEqual(session.lastURL, url)
    }

    func testRequestResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask

        guard let url = URL(string: "https://mockurl") else {
            print("URL can't be empty")
            return
        }
        sut?.request(from: url) { _ in }

        XCTAssert(dataTask.resumeWasCalled)
    }

    func testRequestReturnedData() {
        let expectedData = "{}".data(using: .utf8)
        guard let url = URL(string: "https://mockurl") else {
            print("URL can't be empty")
            return
        }
        session.nextData = expectedData
        var actualData: Data?
        sut?.request(from: url) { result in
            switch result {
            case .success(let data):
                actualData = data
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            }
        }

        XCTAssertNotNil(actualData)
    }

    func testRequestReturnedFailure() {
        let expectedError = NSError(domain: "Page not found", code: 404)
        guard let url = URL(string: "https://mockurl") else {
            print("URL can't be empty")
            return
        }
        session.nextError = expectedError

        var catchError: Error?
        sut?.request(from: url) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                catchError = error
            }
        }

        XCTAssertNotNil(catchError)
    }
}
