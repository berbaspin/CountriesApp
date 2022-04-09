//
//  CountryDetailsPresenter.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 04.04.2022.
//

import Foundation

protocol CountryDetailViewProtocol: AnyObject {
    func setCountry(country: CountryViewData?)
}

protocol CountryDetailsPresenterProtocol: AnyObject {
    init(view: CountryDetailViewProtocol, router: RouterProtocol, country: CountryViewData?)
    func setCountry()
}

class CountryDetailsPresenter: CountryDetailsPresenterProtocol {

    weak var view: CountryDetailViewProtocol?
    var router: RouterProtocol?
    var country: CountryViewData?

    required init(view: CountryDetailViewProtocol, router: RouterProtocol, country: CountryViewData?) {
        self.view = view
        self.router = router
        self.country = country
    }

    func setCountry() {
        view?.setCountry(country: country)
    }

}
