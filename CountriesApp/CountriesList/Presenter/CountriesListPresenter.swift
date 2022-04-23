//
//  CountriesListPresenter.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 04.04.2022.
//

import Foundation

protocol CountriesListViewProtocol: AnyObject {
    func setMoreCountries(_ countries: [CountryViewData], showPagination: Bool)
    func setLatestCountries(_ countries: [CountryViewData], showPagination: Bool)
}

protocol CountriesListPresenterProtocol: AnyObject {
    func getMoreCountries()
    func getLatestCountries()
    func tapOnCountry(country: CountryViewData)
}

class CountriesListPresenter: CountriesListPresenterProtocol {
    weak var view: CountriesListViewProtocol?
    // swiftlint:disable:next implicitly_unwrapped_optional
    let networkDataFetcher: NetworkDataFetcherProtocol!
    // swiftlint:disable:next implicitly_unwrapped_optional
    let coreDataManager: CoreDataManagerProtocol!
    private var router: RouterProtocol?
    private var countries = [CountryViewData]()
    private var urlString: String = API.countries
    private var isLoading = true
    private var newCountries = [CountryViewData]()

    private var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        return formatter
    }()

    init(
        view: CountriesListViewProtocol,
        networkDataFetcher: NetworkDataFetcherProtocol,
        coreDataManager: CoreDataManagerProtocol,
        router: RouterProtocol
    ) {
        self.view = view
        self.networkDataFetcher = networkDataFetcher
        self.coreDataManager = coreDataManager
        self.router = router
        getLatestCountries()
    }

    func getMoreCountries() {
        if !urlString.isEmpty {
            getCountries(from: urlString) { [weak self] countries, urlString in
                guard let self = self else {
                    return
                }
                var durationSeconds = 0.0
                if self.urlString != API.countries {
                    durationSeconds = 2.0
                }
                if let urlString = urlString {
                    self.urlString = urlString
                }
                self.countries += countries

                self.setCountries(duration: durationSeconds)
            }
        } else {
            setCountries(duration: 2.0)
        }
    }
// duration is a delay for displaying pagination
    private func setCountries(duration: Double) {
        var elements = [CountryViewData]()
        if countries.count > 4 {
            elements = Array(countries.prefix(4))
            countries = Array(countries[4 ..< countries.count])
            isLoading = true
        } else {
            elements = Array(countries.prefix(countries.count))
            countries = []
            isLoading = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            if !elements.isEmpty {
                self.view?.setMoreCountries(elements, showPagination: self.isLoading)
            }
        }
    }

    func getLatestCountries() {
        getCountries(from: API.countries) { [weak self] countries, urlString in
            guard let self = self else {
                return
            }

            if let urlString = urlString {
                self.urlString = urlString
            }

            let elements = Array(countries.prefix(4))
            if countries.count > 4 {
                self.countries = Array(countries[4 ..< countries.count])
            }

            DispatchQueue.main.async {
                self.view?.setLatestCountries(elements, showPagination: true)
            }
        }
    }

    private func getCountries(from urlString: String?, completion: @escaping ([CountryViewData], String?) -> Void) {
        guard let urlString = urlString else {
            return
        }

        let group = DispatchGroup()
        group.enter()

        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
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

        group.notify(queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
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
                if !self.newCountries.contains(mappedCountry) {
                    self.newCountries.append(mappedCountry)
                } else {
                    self.newCountries = self.newCountries.filter { $0 != mappedCountry }
                }
            }
            completion(self.newCountries, self.urlString)
        }
    }

    func tapOnCountry(country: CountryViewData) {
        router?.showDetails(country: country)
    }

}
