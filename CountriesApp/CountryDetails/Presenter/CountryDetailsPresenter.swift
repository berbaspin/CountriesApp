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

    private weak var view: CountryDetailViewProtocol?
    var router: RouterProtocol? // зачем?
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

// 1. Private, lel, optional, final, любые слова, которые могут быть не написаны, не пишем
// 2. guard
// 3. Лишние переменные, лишние функции, лишние строки - пытаемся убирать
// 4. Если тебя что-то смущает, то ты сначала думаешь как это решить, спрашиваешь, а потом кидаешь на ревью

