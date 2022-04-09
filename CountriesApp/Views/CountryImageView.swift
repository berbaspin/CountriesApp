//
//  CountryImageView.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 06.04.2022.
//

import UIKit

class WebImageView: UIImageView {
    
    func fetchImage(from url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: imageUrl)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        
        ImageManager.shared.getImage(from: imageUrl) { data, response in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
    
}
