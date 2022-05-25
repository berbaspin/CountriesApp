//
//  BundleExtention.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 25.05.2022.
//

@testable import CountriesApp
import Foundation

extension Bundle {
    static func loadJSONData(filename: String) -> Data? {
        if let url = self.main.url(forResource: filename, withExtension: "json") {
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
