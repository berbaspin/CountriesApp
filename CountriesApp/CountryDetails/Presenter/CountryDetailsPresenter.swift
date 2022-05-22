//
//  CountryDetailsPresenter.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 04.04.2022.
//

import Foundation

protocol CountryDetailViewProtocol: AnyObject {
    func setData(country: CountryViewData, images: [String], showPageControl: Bool)
}

protocol CountryDetailsPresenterProtocol {
    func getData()
}

final class CountryDetailsPresenter: CountryDetailsPresenterProtocol {

    private weak var view: CountryDetailViewProtocol?
    private let country: CountryViewData

    init(view: CountryDetailViewProtocol, country: CountryViewData) {
        self.view = view
        self.country = country
    }

    func getData() {
        view?.setData(country: country, images: country.images, showPageControl: country.images.count > 1)
    }
}
