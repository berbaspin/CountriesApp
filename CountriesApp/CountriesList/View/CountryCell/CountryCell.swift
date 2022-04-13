//
//  CountryCell.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 05.04.2022.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet private var countryImage: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var capitalLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var imageActivityIndicator: UIActivityIndicatorView!

    func setup(country: CountryViewData) {
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        descriptionLabel.text = country.shortDescription

        imageActivityIndicator.startAnimating()
        imageActivityIndicator.hidesWhenStopped = true

        self.countryImage.load(from: country.flag)
        DispatchQueue.main.async {
            self.imageActivityIndicator.stopAnimating()
        }

    }
}
