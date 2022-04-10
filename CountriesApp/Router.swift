//
//  Router.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 05.04.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set } // зачем опциональное если в конструкторе сразу присваиваешь? Зачем мутабельные?
    var assemblyBuilder: AssemblyBuilderProtocol? { get set } // может я пропустил, но зачем добавлять эти свойства в протокол?
}

protocol RouterProtocol: RouterMain {// а точно иерархия наследования не наоборот должна быть? А то получается что все роутеры в проекте будут конформить RouterMain. Я бы сказал, что это RouterMain должен наследоваться от RouterProtocol. Либо я чет не понял
    func initialViewController() // функция должна начинаться с глагола. Может initialize?
    func showDetails(country: CountryViewData?) // почему здесь optional
}

/* final - хороший тон*/class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {// guard можно через запятую писать
            guard let countriesListViewController = assemblyBuilder?.createCoutriesListModule(router: self) else { return }
            navigationController.viewControllers = [countriesListViewController]
        }
    }

    func showDetails(country: CountryViewData?) {
        if let navigationController = navigationController { // guard
            guard let detailsViewController = assemblyBuilder?.createCountryDetailsModule(country: country, router: self) else { return }
            navigationController.pushViewController(detailsViewController, animated: true)
        }
    }
}
