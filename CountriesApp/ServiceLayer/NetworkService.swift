//
//  NetworkService.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 05.04.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) // посмотри про тип Result
  // Data?, Error? это немного старый способ
}

class NetworkService: NetworkServiceProtocol {
  /* private let urlSession: URLSession

   init(urlSessionConfiguration: URLSessionConfiguration) {
   self.urlSession = URLSession(configuration: urlSessionConfiguration)// и ниже используешь не shared, а ее
   */
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
              // а зачем здесь главный поток? А если функция вызывалась не с главного потока, ты неожиданно вернешь на главный?
                completion(data, error)
            }
        }
    }
}
