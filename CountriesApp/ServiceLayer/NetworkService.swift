//
//  NetworkService.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 05.04.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func request(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func createDataTask(
        from request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request) { data, _, error  in

            if let error = error {
                completion(.failure(error))
                return
            } else {
                completion(.success(data ?? Data()))
            }
        }
    }
}
