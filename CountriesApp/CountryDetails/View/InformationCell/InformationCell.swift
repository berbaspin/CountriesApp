//
//  InformationTableViewCell.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import UIKit

class InformationCell: UITableViewCell {

    @IBOutlet private var fieldImage: UIImageView!
    @IBOutlet private var fieldLabel: UILabel!
    @IBOutlet private var countryDetailLabel: UILabel!

    func setup(index: Int, country: CountryViewData) {

        switch index {
        case 0:
            fieldImage.image = UIImage(systemName: "star")
            fieldLabel.text = "Capital"
            countryDetailLabel.text = country.capital
        case 1:
            fieldImage.image = UIImage(systemName: "face.smiling")
            fieldLabel.text = "Population"
            countryDetailLabel.text = country.population
        case 2:
            fieldImage.image = UIImage(systemName: "globe.asia.australia")
            fieldLabel.text = "Continent"
            countryDetailLabel.text = country.continent
        default:
            fieldLabel.text = "???"
        }
    }

}
