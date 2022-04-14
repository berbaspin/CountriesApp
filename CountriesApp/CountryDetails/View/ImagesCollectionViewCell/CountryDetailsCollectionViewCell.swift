//
//  CountryDetailsCollectionViewCell.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import UIKit

class CountryDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var image: UIImageView!
    private var imageURL: String? {
        didSet {
            if let url = imageURL {
                self.image.image = UIImage(named: "imagePlaceholder")
                UIImage.loadImageUsingCache(from: url) { image in
                    if url == self.imageURL {
                        self.image.image = image
                    }
                }
            } else {
                self.image.image = nil
            }
        }
    }
    func setup(imageString: String) {
        imageURL = imageString
    }

}
