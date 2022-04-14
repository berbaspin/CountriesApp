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

    private var countryImageURL: String? {
        didSet {
            if let url = countryImageURL {
                self.countryImage.image = UIImage(named: "imagePlaceholder")
                UIImage.loadImageUsingCache(from: url) { image in
                    if url == self.countryImageURL {
                        self.countryImage.image = image
                    }
                }
            } else {
                self.countryImage.image = nil
            }
        }
    }

    func setup(country: CountryViewData) {
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        descriptionLabel.text = country.shortDescription
        countryImageURL = country.flag
    }
}
