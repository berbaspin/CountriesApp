//
//  CountryCell.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 05.04.2022.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var countryImage: WebImageView! // final, убрать weak, private
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView! // вот это можно спрятать внутрь картинки, чтобы каждый раз не создавать

  // вопрос на самостоятельное обучение. Как работает dequeueReusableCell? Что означает Reusable?
  // может ли быть ячейка переиспользована для новой информации? Что в этом случае произойдет с асинхронной операцией загруки картинки?

    func setup(country: CountryViewData) {
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        descriptionLabel.text = country.shortDescription

        imageActivityIndicator.startAnimating()
        imageActivityIndicator.hidesWhenStopped = true

        DispatchQueue.main.async { // почему загрузка начинается с главного потока?
            self.countryImage.fetchImage(from: country.flag)
            self.imageActivityIndicator.stopAnimating() // анимация закончится сразу же. Пользователь не увидит лоадера
        }

    }
}
