//
//  NetworkService.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 05.04.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {

    private let session: URLSessionProtocol

    init(session: URLSessionProtocol) {
        self.session = session
    }

    func request(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func createDataTask(
        from request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionDataTaskProtocol {
        session.dataTask(with: request) { data, _, error  in

            switch (data, error) {
            case let (.some(data), nil):
                completion(.success(data))
            case let (_, .some(error)):
                completion(.failure(error))
            case (nil, nil):
                print("Problem with creating a Data Task")
            }
        }
    }
}
