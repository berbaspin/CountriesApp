//
//  CountryDetailsPresenter.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 04.04.2022.
//

import Foundation

protocol CountryDetailViewProtocol: AnyObject {
    func setCountry(country: CountryViewData)
    func setImages(_ images: [String], showPageControl: Bool)
}

protocol CountryDetailsPresenterProtocol {
    func getCountry()
    func getImages()
    var country: CountryViewData { get set }
}

final class CountryDetailsPresenter: CountryDetailsPresenterProtocol {

    private weak var view: CountryDetailViewProtocol?
    var country: CountryViewData

    init(view: CountryDetailViewProtocol, country: CountryViewData) {
        self.view = view
        self.country = country
    }

    func getImages() {
        let images = country.images
        if images.count > 1 {
            view?.setImages(images, showPageControl: true)
        } else {
            view?.setImages(images, showPageControl: false)
        }
    }

    func getCountry() {
        view?.setCountry(country: country)
    }

}
