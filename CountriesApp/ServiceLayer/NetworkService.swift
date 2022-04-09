//
//  NetworkService.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 05.04.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
