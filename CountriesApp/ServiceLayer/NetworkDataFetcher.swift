//
//  NetworkDataFetcher.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 05.04.2022.
//

import Foundation

protocol DataFetcherProtocol {
    func getCountries(from urlString: String, response: @escaping ([Country]?, String?) -> Void)
}

class NetworkDataFetcher: DataFetcherProtocol {

    let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func getCountries(from urlString: String, response: @escaping ([Country]?, String?) -> Void) {
        networkService.request(urlString: urlString) { [weak self] data, error in
            if let error = error {
                print("Error received requesting: \(error.localizedDescription)")
            }
            let decoded = self?.decodeJSON(type: CountriesWrapped.self, from: data)
            response(decoded?.countries, decoded?.next)
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }

        do {
            let decodedData = try decoder.decode(type.self, from: data)
            return decodedData
        } catch let error as NSError {
            print("Failed \(error.localizedDescription)")
            return nil
        }

    }

}
