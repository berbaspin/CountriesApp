//
//  CountriesListPresenter.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 04.04.2022.
//

import Foundation

protocol CountriesListViewProtocol: AnyObject {
    func setCountries(_ countries: [CountryViewData])
    func setOneCountry(_ country: CountryViewData)
    var isLoading: Bool { get set }
}

protocol CountriesListPresenterProtocol: AnyObject {
    init(view: CountriesListViewProtocol, dataFetcher: DataFetcherProtocol, router: RouterProtocol)
    func getCountries()
    func getOneCountry(numberOfCountries: Int)
    func tapOnCountry(country: CountryViewData)
}

class CountriesListPresenter: CountriesListPresenterProtocol {
    weak var view: CountriesListViewProtocol?
    let dataFetcher: DataFetcherProtocol!
    var router: RouterProtocol?
    private var countries = [CountryViewData]()
    private var urlString: String = API.countries
    
    private var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        return formatter
    }()
    
    required init(view: CountriesListViewProtocol, dataFetcher: DataFetcherProtocol, router: RouterProtocol) {
        self.view = view
        self.dataFetcher = dataFetcher
        self.router = router
        getCountries()
    }
    
    func getCountries() {
        
        if let view = view, !view.isLoading {
            if !self.urlString.isEmpty {
                view.isLoading = true
            }
            
            dataFetcher.getCountries(from: self.urlString) { [weak self] countries, urlString in
                guard let self = self else { return }
                
                var durationSeconds = 0.0
                if self.urlString != API.countries {
                    durationSeconds = 2.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + durationSeconds) {
                    if let countries = countries {
                        let mappedCountries = countries.map {
                            return CountryViewData(name: $0.name,
                                                   capital: $0.capital,
                                                   population: self.numberFormatter.string(from: $0.population as NSNumber) ?? "0",
                                                   continent: $0.continent,
                                                   description: $0.description,
                                                   shortDescription: $0.descriptionSmall ?? "",
                                                   flag: $0.countryInfo.flag,
                                                   images: $0.countryInfo.images.isEmpty ? [$0.countryInfo.flag] : $0.countryInfo.images
                            )
                        }
                        if let urlString = urlString {
                            self.urlString = urlString
                        }
                        self.countries += mappedCountries
                        self.view?.setCountries(self.countries)
                        
                        
                    }
                }
            }
        }
    }
    
    func getOneCountry(numberOfCountries: Int) {
        if countries.count  == numberOfCountries {
            dataFetcher.getCountries(from: urlString) { [weak self] countries, urlString in
                guard let self = self else { return }
                if let countries = countries {
                    let mappedCountries = countries.map {
                        return CountryViewData(name: $0.name,
                                               capital: $0.capital,
                                               population: self.numberFormatter.string(from: $0.population as NSNumber) ?? "0",
                                               continent: $0.continent,
                                               description: $0.description,
                                               shortDescription: $0.descriptionSmall ?? "",
                                               flag: $0.countryInfo.flag,
                                               images: $0.countryInfo.images.isEmpty ? [$0.countryInfo.flag] : $0.countryInfo.images
                        )
                    }
                    if let urlString = urlString {
                        self.urlString = urlString
                    }
                    self.countries += mappedCountries
                    self.view?.setOneCountry(self.countries[numberOfCountries])
                }
            }
        } else {
            view?.setOneCountry(countries[numberOfCountries])
        }
    }
    
    func tapOnCountry(country: CountryViewData) {
        router?.showDetails(country: country)
    }
    
}
