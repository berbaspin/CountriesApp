//
//  CountriesListPresenter.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 04.04.2022.
//

import Foundation

protocol CountriesListViewProtocol: AnyObject {
    func setCountries(_ countries: [CountryViewData], showPagination: Bool)
}

protocol CountriesListPresenterProtocol {
    func getMoreCountries()
    func getLatestCountries()
    func tapOnCountry(country: CountryViewData)
}

final class CountriesListPresenter: CountriesListPresenterProtocol {
    private weak var view: CountriesListViewProtocol?
    private let networkDataFetcher: NetworkDataFetcherProtocol
    private let coreDataManager: CoreDataManagerProtocol
    private var router: RouterProtocol?
    private var countries = [CountryViewData]()
    private var url = URL(string: API.countries)
    private var isLoading = true
    private let numberOfCountriesToReturn = 4
    private var countriesToDisplay = [CountryViewData]()

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
        // coreDataManager.deleteAllCountries()
        // coreDataManager.deleteAllImages()
    }

    func getMoreCountries() {
        guard let url = url else {
            setCountries(duration: 2.0)
            return
        }

        getCountries(from: url) { [weak self] countries, urlString in
            guard let self = self else {
                return
            }
            var durationSeconds = 0.0
            if self.url != URL(string: API.countries) {
                durationSeconds = 2.0
            }
            if let urlString = urlString {
                self.url = urlString
            }
            self.setCountries(duration: durationSeconds)
        }
    }

// duration is used to show a delay to display pagination, because API is too fast
// variable "duration" adds 2 second delay
// variable "numberOfCountriesToReturn" help to show 4 elements per request

    private func setCountries(duration: Double) {
        if (countries.count - countriesToDisplay.count) > numberOfCountriesToReturn {
            self.countriesToDisplay = Array(countries.prefix(self.countriesToDisplay.count + numberOfCountriesToReturn))
            isLoading = true
        } else {
            self.countriesToDisplay = countries
            isLoading = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.view?.setCountries(self.countriesToDisplay, showPagination: self.isLoading)
        }
    }

    func getLatestCountries() {
        guard let url = URL(string: API.countries) else {
            return
        }
        getCountries(from: url) { [weak self] countries, url in
            guard let self = self else {
                return
            }

            if let url = url {
                self.url = url
            }

            self.countriesToDisplay = Array(countries.prefix(self.numberOfCountriesToReturn))
            DispatchQueue.main.async {
                self.view?.setCountries(self.countriesToDisplay, showPagination: true)
            }
        }
    }

    private func getCountries(from url: URL?, completion: @escaping ([CountryViewData], URL?) -> Void) {
        guard let url = url else {
            return
        }

        self.networkDataFetcher.getCountries(from: url) { [weak self] countries, url in
            guard let self = self else {
                return
            }
            if let url = url {
                self.url = url
            }

            for country in countries {
                self.coreDataManager.saveCountry(country: country)
            }

            self.getLocalData()
            completion(self.countries, self.url)
        }
    }

    private func getLocalData() {
        let countries = coreDataManager.getCountries()
        self.countries = countries.map {
            CountryViewData(
                name: $0.name,
                capital: $0.capital,
                population: numberFormatter.string(from: $0.population as NSNumber) ?? "0",
                continent: $0.continent,
                description: $0.longDescription ?? "",
                shortDescription: $0.smallDescription ?? "",
                flag: $0.flag,
                images: getImages(country: $0)
            )
        }
    }

    private func getImages(country: CountryData) -> [String] {
        let countryImages = country.images?.allObjects as? [CountryImages]
        guard let countryImages = countryImages,
            !countryImages.isEmpty else {
            return [country.flag]
        }
        return countryImages.map {
            $0.imageUrl
        }
    }

    func tapOnCountry(country: CountryViewData) {
        router?.showDetails(country: country)
    }

}
