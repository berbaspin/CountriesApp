//
//  CountryCell.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 05.04.2022.
//

import UIKit

final class CountryCell: UITableViewCell {

    @IBOutlet private var countryImage: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var capitalLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    private var imageRequest: URLSessionDataTaskProtocol?

    override func prepareForReuse() {
        super.prepareForReuse()
        countryImage.image = nil
        imageRequest?.cancel()
    }

    func setup(country: CountryViewData) {
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        descriptionLabel.text = country.shortDescription
        imageRequest = countryImage.loadUsingCache(from: country.flag)
    }
}
