//
//  CountryDetailsCollectionViewCell.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import UIKit

final class CountryDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var countryImageView: UIImageView!
    private var imageRequest: URLSessionDataTaskProtocol?

    override func prepareForReuse() {
        super.prepareForReuse()
        countryImageView.image = nil
        imageRequest?.cancel()
    }

    func setup(imageString: String) {
        imageRequest = countryImageView.loadUsingCache(from: imageString)
    }

}
