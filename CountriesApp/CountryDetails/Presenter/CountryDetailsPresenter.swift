//
//  CountryDetailsPresenter.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 04.04.2022.
//

import Foundation

protocol CountryDetailViewProtocol: AnyObject {
    func setCountry(country: CountryViewData)
    func setImages(_ images: [String], showPageControl: Bool) // объединить
}

protocol CountryDetailsPresenterProtocol {
    func getCountry()
    func getImages() // объединить
}

final class CountryDetailsPresenter: CountryDetailsPresenterProtocol {

    private weak var view: CountryDetailViewProtocol?
    var country: CountryViewData // а можно let

    init(view: CountryDetailViewProtocol, country: CountryViewData) {
        self.view = view
        self.country = country
    }

    func getImages() {
      view?.setImages( country.images, showPageControl: images.count > 1 )
    } // объединить

    func getCountry() {
        view?.setCountry(country: country)
    }

}
