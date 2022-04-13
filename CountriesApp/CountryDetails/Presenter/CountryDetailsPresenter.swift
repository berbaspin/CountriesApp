//
//  CountryDetailsPresenter.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 04.04.2022.
//

import Foundation

protocol CountryDetailViewProtocol: AnyObject {
    func setCountry(country: CountryViewData)
}

protocol CountryDetailsPresenterProtocol: AnyObject {
    func setCountry()
}

class CountryDetailsPresenter: CountryDetailsPresenterProtocol {

    weak var view: CountryDetailViewProtocol?
    var router: RouterProtocol?
    var country: CountryViewData?

    init(view: CountryDetailViewProtocol, router: RouterProtocol, country: CountryViewData?) {
        self.view = view
        self.router = router
        self.country = country
    }

    func setCountry() {
        guard let country = country else {
            return
        }
        view?.setCountry(country: country)
    }

}
