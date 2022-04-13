//
//  NetworkDataFetcher.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 05.04.2022.
//

import Foundation

protocol DataFetcherProtocol {
    func getCountries(from urlString: String, response: @escaping ([Country], String?) -> Void)
}

class NetworkDataFetcher: DataFetcherProtocol {

    private let networkService: NetworkServiceProtocol
    private let decoder = JSONDecoder()

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func getCountries(from urlString: String, response: @escaping ([Country], String?) -> Void) {
        networkService.request(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                let decoded = self?.decodeJSON(type: CountriesWrapped.self, from: data)
                response(decoded?.countries ?? [], decoded?.next)
            case .failure(let error):
                print("Error received requesting: \(error.localizedDescription)")
            }
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data else {
            return nil
        }

        do {
            let decodedData = try decoder.decode(type.self, from: data)
            return decodedData
        } catch let error as NSError {
            print("Failed \(error.localizedDescription)")
            return nil
        }

    }

}
