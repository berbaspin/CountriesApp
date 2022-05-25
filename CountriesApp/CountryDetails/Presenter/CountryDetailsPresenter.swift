//
//  CountryDetailsPresenter.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 04.04.2022.
//

import Foundation

protocol CountryDetailViewProtocol: AnyObject {
    func setData(
        country: CountryViewData,
        images: [String],
        countryInformation: [CountryInformation],
        showPageControl: Bool
    )
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
        let capital = CountryInformation(
            type: CountryInformation.CountryInformationType.capital,
            text: country.capital
        )
        let population = CountryInformation(
            type: CountryInformation.CountryInformationType.population,
            text: country.population
        )
        let continent = CountryInformation(
            type: CountryInformation.CountryInformationType.continent,
            text: country.continent
        )
        let countryInformation = [capital, population, continent]

        view?.setData(
            country: country,
            images: country.images,
            countryInformation: countryInformation,
            showPageControl: country.images.count > 1
        )
    }
}
