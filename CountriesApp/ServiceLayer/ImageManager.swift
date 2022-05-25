//
//  ImageManager.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import Foundation

protocol ImageManagerProtocol {
    func getImage(
        from url: URL,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}

final class ImageManager: ImageManagerProtocol {

    private let session: URLSessionProtocol

    static var shared = ImageManager()

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func getImage(
        from url: URL,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response else {
                print(String(describing: error))
                completion(nil, nil, error)
                return
            }
            completion(data, response, nil)
        }

        task.resume()
        return task
    }

}
