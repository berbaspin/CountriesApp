//
//  URLSession.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 19.05.2022.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

// MARK: - URLSessionProtocol
extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        (dataTask(
            with: request,
            completionHandler: completionHandler
        ) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}
