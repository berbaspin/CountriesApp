//
//  LocalJSONLoader.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 25.05.2022.
//

import Foundation

protocol JSONLoader {
    func load(filename: String) -> Data?
}

final class LocalJSONLoader {

    init() {}

    func load(filename: String) -> Data? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("Error: \(error)")
            }
        }
        return nil
    }
}
