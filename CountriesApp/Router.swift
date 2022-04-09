//
//  Router.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 05.04.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetails(country: CountryViewData?)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let countriesListViewController = assemblyBuilder?.createCoutriesListModule(router: self) else { return }
            navigationController.viewControllers = [countriesListViewController]
        }
    }
    
    func showDetails(country: CountryViewData?) {
        if let navigationController = navigationController {
            guard let detailsViewController = assemblyBuilder?.createCountryDetailsModule(country: country, router: self) else { return }
            navigationController.pushViewController(detailsViewController, animated: true)
        }
    }
}
