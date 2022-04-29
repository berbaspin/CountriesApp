//
//  NetworkDataFetcher.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 05.04.2022.
//

import Foundation

protocol NetworkDataFetcherProtocol {
    func getCountries(from url: URL, response: @escaping ([Country], URL?) -> Void)
}

final class NetworkDataFetcher: NetworkDataFetcherProtocol {

    private let networkService: NetworkServiceProtocol
    private let decoder = JSONDecoder()

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func getCountries(from url: URL, response: @escaping ([Country], URL?) -> Void) {
        networkService.request(from: url) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                let decoded = try? self.decoder.decode(CountriesWrapped.self, from: data)
                response(decoded?.countries ?? [], URL(string: decoded?.next ?? ""))
            case .failure(let error):
                print("Error received requesting: \(error.localizedDescription)")
            }
        }
    }
}
