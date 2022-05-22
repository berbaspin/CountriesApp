//
//  URLSessionDataTask.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 19.05.2022.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

// MARK: - URLSessionDataTaskProtocol
extension URLSessionDataTask: URLSessionDataTaskProtocol {}
