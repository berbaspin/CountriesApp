//
//  Router.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 05.04.2022.
//

import UIKit

protocol RouterProtocol {
    func initializeViewController()
    func showDetails(country: CountryViewData)
}

final class Router: RouterProtocol {
    private let navigationController: UINavigationController
    private let assemblyBuilder: AssemblyBuilderProtocol

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func initializeViewController() {
        let countriesListViewController = assemblyBuilder.createCoutriesListModule(router: self)
        navigationController.viewControllers = [countriesListViewController]
    }

    func showDetails(country: CountryViewData) {
        let detailsViewController = assemblyBuilder.createCountryDetailsModule(country: country, router: self)
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
