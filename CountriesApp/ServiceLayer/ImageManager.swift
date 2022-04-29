//
//  ImageManager.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import Foundation

protocol ImageManagerProtocol {
    func getImage(from url: URL, completion: @escaping (Data, URLResponse) -> Void) -> URLSessionDataTask
}

final class ImageManager: ImageManagerProtocol {

    static var shared = ImageManager()

    private init() {}

    func getImage(from url: URL, completion: @escaping (Data, URLResponse) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            completion(data, response)
        }

        task.resume()
        return task
    }

}
