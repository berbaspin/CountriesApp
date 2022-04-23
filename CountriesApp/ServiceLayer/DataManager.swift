//
//  DataManager.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 19.04.2022.
//

import Foundation

class DataService {
    private let networkDataFetcher = NetworkDataFetcher(networkService: NetworkService())
    private let coreDataManager = CoreDataManager()
    private var urlString = API.countries
    private var newData = [CountryViewData]()

    private var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        return formatter
    }()

//    func getCountries(from urlString: String?, completion: @escaping ([CountryViewData], String?) -> Void) {
//        getLocalData(from: urlString, completion: completion)
//        // coreDataManager.deleteAllCountries()
//        // coreDataManager.deleteAllImages()
//    }

    func getCountries(from urlString: String?, completion: @escaping ([CountryViewData], String?) -> Void) {
        guard let urlString = urlString else {
            return
        }

        let group = DispatchGroup()
        group.enter()

        DispatchQueue.main.async {
            self.networkDataFetcher.getCountries(from: urlString) { countries, urlString in
                if let urlString = urlString {
                    self.urlString = urlString
                }

                for country in countries {
                    self.coreDataManager.saveCountry(country: country)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            let countries = self.coreDataManager.getCountries()
            let mappedCountries = countries.map {
                CountryViewData(
                    name: $0.name ?? "",
                    capital: $0.capital ?? "",
                    population: self.numberFormatter.string(from: $0.population as NSNumber) ?? "0",
                    continent: $0.continent ?? "",
                    description: $0.longDescription ?? "",
                    shortDescription: $0.smallDescription ?? "",
                    flag: $0.flag ?? "",
                    images:
                        !($0.images?.allObjects as? [CountryImages] ?? []).isEmpty
                    ? ($0.images?.allObjects as? [CountryImages] ?? []).map { $0.imageUrl ?? "" }
                    : [$0.flag ?? ""]
                )
            }

            for mappedCountry in mappedCountries {
                if !self.newData.contains(mappedCountry) {
                    self.newData.append(mappedCountry)
                } else {
                    self.newData = self.newData.filter { $0 != mappedCountry }
                }
            }
            completion(self.newData, self.urlString)
        }
    }
}
