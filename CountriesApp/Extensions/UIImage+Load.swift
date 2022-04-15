//
//  WebImageView.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 06.04.2022.
//

import UIKit

extension UIImage {
    static func loadImageUsingCache(from urlString: String, completion: @escaping (UIImage) -> Void) {

        guard let imageUrl = URL(string: urlString) else {
            return
        }

        if let cachedImageData = CacheManager.shared.getData(for: imageUrl),
        let cachedImage = UIImage(data: cachedImageData) {
            completion(cachedImage)
        }

        ImageManager.shared.getImage(from: imageUrl) { data, response in
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data) {
                    CacheManager.shared.saveData(with: data, response: response)
                    completion(downloadedImage)
                }
            }
        }
    }
}
