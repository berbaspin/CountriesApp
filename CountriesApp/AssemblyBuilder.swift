//
//  AssemblyBuilder.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 05.04.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createCoutriesListModule(router: RouterProtocol) -> UIViewController
    func createCountryDetailsModule(country: CountryViewData, router: RouterProtocol) -> UIViewController
}

final class AsseblyBuilder: AssemblyBuilderProtocol {
    func createCoutriesListModule(router: RouterProtocol) -> UIViewController {
        let countriesListViewController = CountriesListViewController()
        let networkService = NetworkService(session: URLSession.shared)
        let networkDataFetcher = NetworkDataFetcher(networkService: networkService)
        let coreDataManager = CoreDataManager()
        let presenter = CountriesListPresenter(
            view: countriesListViewController,
            networkDataFetcher: networkDataFetcher,
            coreDataManager: coreDataManager,
            router: router
        )
        countriesListViewController.presenter = presenter
        return countriesListViewController
    }

    func createCountryDetailsModule(country: CountryViewData, router: RouterProtocol) -> UIViewController {
        let countryDetailsViewController = CountryDetailsViewController()
        let presenter = CountryDetailsPresenter(view: countryDetailsViewController, country: country)
        countryDetailsViewController.presenter = presenter
        return countryDetailsViewController
    }
}
