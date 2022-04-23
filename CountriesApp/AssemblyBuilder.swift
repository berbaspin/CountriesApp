//
//  AssemblyBuilder.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 05.04.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createCoutriesListModule(router: RouterProtocol) -> UIViewController
    func createCountryDetailsModule(country: CountryViewData?, router: RouterProtocol) -> UIViewController
}

class AssenlyBuilder: AssemblyBuilderProtocol {
    func createCoutriesListModule(router: RouterProtocol) -> UIViewController {
        let viewVC = CountriesListViewController()
        let networkService = NetworkService()
        let networkDataFetcher = NetworkDataFetcher(networkService: networkService)
        let coreDataManager = CoreDataManager()
        let presenter = CountriesListPresenter(
            view: viewVC,
            networkDataFetcher: networkDataFetcher,
            coreDataManager: coreDataManager,
            router: router
        )
        viewVC.presenter = presenter
        return viewVC
    }

    func createCountryDetailsModule(country: CountryViewData?, router: RouterProtocol) -> UIViewController {
        let viewVC = CountryDetailsViewController()
        let presenter = CountryDetailsPresenter(view: viewVC, router: router, country: country)
        viewVC.presenter = presenter
        return viewVC
    }
}
