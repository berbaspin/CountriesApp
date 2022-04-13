//
//  WebImageView.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 06.04.2022.
//

import UIKit

extension UIImageView {
    func load(from urlString: String) {
        guard let imageUrl = URL(string: urlString) else {
            return
        }

        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: imageUrl)) {
            DispatchQueue.main.async {
                self.image = UIImage(data: cachedResponse.data)
            }
            return
        }
        ImageManager.shared.getImage(from: imageUrl) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.image = UIImage(named: "imagePlaceholder")
                }
                print("Error received requesting: \(error.localizedDescription)")
            }
        }
    }
}
