//
//  CountryDetailsCollectionViewCell.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import UIKit

final class CountryDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var image: UIImageView!

    private var imageURL: String? { // не нужно свойство
        didSet {
            if let url = imageURL {
                self.image.image = UIImage(named: "imagePlaceholder")
                UIImage.loadImageUsingCache(from: url) { image in // плохой способ решить проблему
                    if url == self.imageURL {
                        self.image.image = image
                    }
                }
            } else {
                self.image.image = nil
            }
        }
    }


    override func prepareForReuse() {
        super.prepareForReuse()
        //image.af.cancelRequests() // отменять асинк запросы картинки
    }

    func setup(imageString: String) {
        imageURL = imageString
    }

}
