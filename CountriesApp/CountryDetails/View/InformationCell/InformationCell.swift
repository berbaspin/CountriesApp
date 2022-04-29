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

  // ячейка должна быть тупой, она не решает что ей показать, она показывает то что дали на вход
  func setup(with model: CountryInformation, text: String) {
        fieldImage.image = UIImage(systemName: countryInformation.icon)
        fieldLabel.text = countryInformation.rawValue.capitalized
        countryDetailLabel.text = text
    }

}
