//
//  NetworkDataFetcher.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 05.04.2022.
//

import Foundation

struct Page<T> {
    let entities: [T]
    let nextPage: URL
}

protocol NetworkDataFetcherProtocol {
    func getCountries(from urlString: String, response: @escaping ([Country], String?) -> Void) // улучшить апи
}

final class NetworkDataFetcher: NetworkDataFetcherProtocol {

    private let networkService: NetworkServiceProtocol
    private let decoder = JSONDecoder()

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func getCountries(from urlString: String, response: @escaping ([Country], String?) -> Void) {
        networkService.request(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                let decoded = try? self?.decoder.decode(CountriesWrapped.self, from: data)
                response(decoded?.countries ?? [], decoded?.next)
            case .failure(let error):
                print("Error received requesting: \(error.localizedDescription)")
            }
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data) -> T? { // метод не нужен
        do {
            let decodedData = try decoder.decode(type.self, from: data)
            return decodedData
        } catch { // не нужно NSError
            print("Failed \(error.localizedDescription)")
            return nil
        }

    }

}
