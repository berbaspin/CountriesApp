//
//  CacheManager.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 14.04.2022.
//

import UIKit

protocol CacheManagerProtocol {
    func saveData(with data: Data, response: URLResponse)
    func getData(for url: URL) -> UIImage?
}

class CacheManager: CacheManagerProtocol {

    static let shared = CacheManager()

    private init() {}

    func saveData(with data: Data, response: URLResponse) {
        guard let url = response.url else {
            return
        }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }

    func getData(for url: URL) -> UIImage? {
        let request = URLRequest(url: url)

        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
