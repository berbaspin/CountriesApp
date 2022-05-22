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

    func setup(with model: CountryInformation, text: String) {
        fieldImage.image = UIImage(systemName: model.icon)
        fieldLabel.text = model.rawValue.capitalized
        countryDetailLabel.text = text
    }
}
