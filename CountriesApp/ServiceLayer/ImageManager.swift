//
//  ImageManager.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import Foundation

protocol ImageManagerProtocol {
    func getImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

class ImageManager: ImageManagerProtocol {

    static var shared = ImageManager()

    private init() {}

    func getImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(data ?? Data()))
            }
        }
        .resume()
    }

}
