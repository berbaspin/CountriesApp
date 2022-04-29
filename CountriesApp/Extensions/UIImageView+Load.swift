//
//  WebImageView.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 06.04.2022.
//

import UIKit

extension UIImageView {

    func loadUsingCache(
        from urlString: String,
        placeholder: UIImage? = UIImage(named: "imagePlaceholder")
    ) -> URLSessionDataTask? {
        self.image = placeholder
        guard let imageUrl = URL(string: urlString) else {
            return nil
        }

        if let cachedImageData = CacheManager.shared.getData(for: imageUrl),
        let cachedImage = UIImage(data: cachedImageData) {
            image = cachedImage
        }

        let task = ImageManager.shared.getImage(from: imageUrl) { [weak self] data, response in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                guard let downloadedImage = UIImage(data: data) else {
                    return
                }
                CacheManager.shared.saveData(with: data, response: response)
                self.image = downloadedImage

            }
        }
        return task
    }
}
