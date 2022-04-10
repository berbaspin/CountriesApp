//
//  CountryDetailsCollectionViewCell.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 06.04.2022.
//

import UIKit

class CountryDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: WebImageView!

    func setup(imageString: String) {
        DispatchQueue.main.async { // зачем?
            self.image.fetchImage(from: imageString)
        }
    }

}
