//
//  InformationTableViewCell.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import UIKit

final class InformationCell: UITableViewCell {

    @IBOutlet private var fieldImage: UIImageView!
    @IBOutlet private var fieldLabel: UILabel!
    @IBOutlet private var countryDetailLabel: UILabel!

    func setup(index: Int, country: CountryViewData) {
        let countryInformation = CountryInformation.allCases[index]

        fieldImage.image = UIImage(systemName: countryInformation.icon)
        fieldLabel.text = countryInformation.rawValue.capitalized

        switch countryInformation {
        case .capital:
            countryDetailLabel.text = country.capital
        case .population:
            countryDetailLabel.text = country.population
        case .continent:
            countryDetailLabel.text = country.continent
        }
    }

}
