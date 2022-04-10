//
//  CountryImageView.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 06.04.2022.
//

import UIKit

class WebImageView: UIImageView { // Не. Строго нет. Сабкласить UIImageView чтобы добавить туда одну функцию это плохо. Тоже самое с UIViewController, UIView и тд. Добавь через extension или через протокол. Могу потом объяснить почему
    func fetchImage(from url: String) { // у тебя в одних функциях URL в других строка. Сделай единообразно. Я бы выбрал строку
        guard let imageUrl = URL(string: url) else {
            return
        }
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: imageUrl)) { // потестировал?
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        ImageManager.shared.getImage(from: imageUrl) { [weak self] data, _ in
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }
    }
}
