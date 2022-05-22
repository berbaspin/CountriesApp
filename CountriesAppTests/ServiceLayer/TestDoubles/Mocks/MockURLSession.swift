//
//  MockURLSession.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 19.05.2022.
//

@testable import CountriesApp
import Foundation

final class MockURLSession: URLSessionProtocol {

    var nextData: Data?
    var nextError: Error?
    var nextDataTask = MockURLSessionDataTask()

    private(set) var lastURL: URL?

    private func successHttpURLResponse(request: URLRequest) -> URLResponse {
        HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }
}
