//
//  CountriesListPresenter.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 04.04.2022.
//

import Foundation

protocol CountriesListViewProtocol: AnyObject {
    func setMoreCountries(_ countries: [CountryViewData])
    func setLatestCountries(_ countries: [CountryViewData])
    var isLoading: Bool { get set }
}

protocol CountriesListPresenterProtocol: AnyObject {
    func getMoreCountries()
    func getLatestCountries()
    func tapOnCountry(country: CountryViewData)
}

class CountriesListPresenter: CountriesListPresenterProtocol {
    weak var view: CountriesListViewProtocol?
    // swiftlint:disable:next implicitly_unwrapped_optional
    let dataFetcher: DataFetcherProtocol!
    private var router: RouterProtocol?
    private var countries = [CountryViewData]()
    private var urlString: String = API.countries

    private var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        return formatter
    }()

    init(view: CountriesListViewProtocol, dataFetcher: DataFetcherProtocol, router: RouterProtocol) {
        self.view = view
        self.dataFetcher = dataFetcher
        self.router = router
        getLatestCountries()
    }

    func getMoreCountries() {
        guard let view = view, !view.isLoading else {
            return
        }
        if !urlString.isEmpty {
            view.isLoading = true

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
            if !self.countries.isEmpty {
                view.isLoading = true
            }
            setCountries(duration: 2.0)
        }
    }
// duration is a delay for displaying pagination
    private func setCountries(duration: Double) {
        var elements = [CountryViewData]()
        if countries.count > 3 {
            elements = Array(countries.prefix(4))
            countries = Array(countries[4 ..< countries.count])
        } else {
            elements = Array(countries.prefix(countries.count))
            countries = []
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            if !elements.isEmpty {
                self.view?.setMoreCountries(elements)
            }
        }
    }

    func getLatestCountries() {
        guard let view = view, !view.isLoading else {
            return
        }
        view.isLoading = true
        getCountries(from: API.countries) { [weak self] countries, urlString in
            guard let self = self else {
                return
            }
            if let urlString = urlString {
                self.urlString = urlString
            }

            let elements = Array(countries.prefix(4))
            self.countries = Array(countries[4 ..< countries.count])
            DispatchQueue.main.async {
                self.view?.setLatestCountries(elements)
            }
        }
    }

    private func getCountries(from urlString: String, completion: @escaping ([CountryViewData], String?) -> Void) {
        dataFetcher.getCountries(from: urlString) { [weak self] countries, urlString in
            guard let self = self else {
                return
            }
            let mappedCountries = countries.map {
                CountryViewData(
                    name: $0.name,
                    capital: $0.capital,
                    population: self.numberFormatter.string(from: $0.population as NSNumber) ?? "0",
                    continent: $0.continent,
                    description: $0.description,
                    shortDescription: $0.descriptionSmall ?? "",
                    flag: $0.countryInfo.flag,
                    images: $0.countryInfo.images.isEmpty ? [$0.countryInfo.flag] : $0.countryInfo.images
                )
            }
            completion(mappedCountries, urlString)
        }
    }

    func tapOnCountry(country: CountryViewData) {
        router?.showDetails(country: country)
    }

}
