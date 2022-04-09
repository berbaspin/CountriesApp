//
//  AssemblyBuilder.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 05.04.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createCoutriesListModule(router: RouterProtocol) -> UIViewController
    func createCountryDetailsModule(country: CountryViewData?, router: RouterProtocol) -> UIViewController
}

class AssenlyBuilder: AssemblyBuilderProtocol {
    func createCoutriesListModule(router: RouterProtocol) -> UIViewController {
        let view = CountriesListViewController()
        let networkService = NetworkService()
        let dataFetcher = NetworkDataFetcher(networkService: networkService)
        let presenter = CountriesListPresenter(view: view, dataFetcher: dataFetcher, router: router)
        view.presenter = presenter
        return view
    }
    
    func createCountryDetailsModule(country: CountryViewData?, router: RouterProtocol) -> UIViewController {
        let view = CountryDetailsViewController()
        let presenter = CountryDetailsPresenter(view: view, router: router, country: country)
        view.presenter = presenter
        return view
    }
}
