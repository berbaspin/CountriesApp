//
//  CountryDetailsCollectionViewCell.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import UIKit

class CountryDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var image: UIImageView!

    func setup(imageString: String) {
        DispatchQueue.main.async { [weak self] in
            self?.image.load(from: imageString)
        }
    }

}
