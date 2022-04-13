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
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func initializeViewController() {
        guard let navigationController = navigationController,
        let countriesListViewController = assemblyBuilder?.createCoutriesListModule(router: self) else {
            return
        }
        navigationController.viewControllers = [countriesListViewController]
    }

    func showDetails(country: CountryViewData) {
        guard let navigationController = navigationController,
        let detailsViewController = assemblyBuilder?.createCountryDetailsModule(country: country, router: self) else {
            return
        }
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
