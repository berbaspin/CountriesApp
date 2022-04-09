//
//  CountryCell.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 05.04.2022.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var countryImage: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!

    func setup(country: CountryViewData) {
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        descriptionLabel.text = country.shortDescription

        imageActivityIndicator.startAnimating()
        imageActivityIndicator.hidesWhenStopped = true

        DispatchQueue.main.async {
            self.countryImage.fetchImage(from: country.flag)
            self.imageActivityIndicator.stopAnimating()
        }

    }
}
