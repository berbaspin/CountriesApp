//
//  WebImageView.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 06.04.2022.
//

import UIKit

extension UIImageView {
    // отменят предыдущий реквест
    func loadUsingCache(from urlString: String, placeholder: UIImage? = UIImage(named: "imagePlaceholder")) {
        self.image = UIImage(named: "imagePlaceholder")

        guard let imageUrl = URL(string: urlString) else {
            return
        }

        if let cachedImageData = CacheManager.shared.getData(for: imageUrl),
        let cachedImage = UIImage(data: cachedImageData) {
            image = cachedImage
        }

        ImageManager.shared.getImage(from: imageUrl) { [weak self] data, response in
            DispatchQueue.main.async {
                guard let downloadedImage = UIImage(data: data) else { return }
                CacheManager.shared.saveData(with: data, response: response)
                self?.image = downloadedImage
            }
        }
    }
}
