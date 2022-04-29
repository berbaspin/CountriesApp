//
//  CountryDetailsCollectionViewCell.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import UIKit

final class CountryDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var countryImageView: UIImageView!
    private var imageRequest: URLSessionDataTask?

    override func prepareForReuse() {
        super.prepareForReuse()
      imageRequest?.cancel()
        countryImageView.image = nil
    }

    func setup(imageString: String) {
        imageRequest = countryImageView.loadUsingCache(from: imageString)
    }

}
