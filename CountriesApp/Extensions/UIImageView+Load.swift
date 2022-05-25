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
        imageManager: ImageManagerProtocol = ImageManager.shared,
        placeholder: UIImage? = UIImage(named: "imagePlaceholder")
    ) -> URLSessionDataTaskProtocol? {
        self.image = placeholder
        guard let imageUrl = URL(string: urlString) else {
            return nil
        }

        if let cachedImageData = CacheManager.shared.getData(for: imageUrl),
        let cachedImage = UIImage(data: cachedImageData) {
            image = cachedImage
        }

        let task = imageManager.getImage(from: imageUrl) { [weak self] data, response, _ in
            guard let self = self else {
                return
            }
            guard let data = data, let response = response else {
                return
            }
            guard let downloadedImage = UIImage(data: data) else {
                return
            }
            CacheManager.shared.saveData(with: data, response: response)
            DispatchQueue.main.async {
                self.image = downloadedImage

            }
        }
        return task
    }
}
