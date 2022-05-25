//
//  MockURLSessionDataTask.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 19.05.2022.
//

@testable import CountriesApp
import Foundation

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {

    private(set) var resumeWasCalled = false
    private(set) var cancelWasCalled = false

    func resume() {
        resumeWasCalled = true
    }

    func cancel() {
        cancelWasCalled = true
    }
}
