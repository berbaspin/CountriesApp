//
//  CountryDetailsViewController.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 06.04.2022.
//

import UIKit

class CountryDetailsViewController: UIViewController {

    @IBOutlet private var imagesCollectionView: UICollectionView!
    @IBOutlet private var imagesPageControl: UIPageControl!
    @IBOutlet private var informationTableView: UITableView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    // swiftlint:disable:next implicitly_unwrapped_optional
    var presenter: CountryDetailsPresenterProtocol!
    private var countryToDisplay: CountryViewData?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setCountry()
        setupImagesCollectionView()
        setupTableView()
        nameLabel.text = countryToDisplay?.name
        descriptionLabel.text = countryToDisplay?.description
    }

    private func setupImagesCollectionView() {
        let imageCell = UINib(nibName: String(describing: CountryDetailsCollectionViewCell.self), bundle: nil)
        imagesCollectionView.register(
            imageCell, forCellWithReuseIdentifier: String(describing: CountryDetailsCollectionViewCell.self)
        )
        setupImagesPageControl()
    }

    private func setupTableView() {
        let informationCell = UINib(nibName: String(describing: InformationCell.self), bundle: nil)
        informationTableView.register(informationCell, forCellReuseIdentifier: String(describing: InformationCell.self))
    }

    private func setupImagesPageControl() {
        guard let countryToDisplay = countryToDisplay else {
            return
        }
        if countryToDisplay.images.count > 1 {
            imagesPageControl.numberOfPages = countryToDisplay.images.count
        } else {
            imagesPageControl.isHidden = true
        }
    }

}

// MARK: - CountryDetailViewProtocol

extension CountryDetailsViewController: CountryDetailViewProtocol {
    func setCountry(country: CountryViewData) {
        countryToDisplay = country
    }
}

// MARK: UICollectionViewDataSource

extension CountryDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countryToDisplay?.images.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: CountryDetailsCollectionViewCell.self), for: indexPath
        ) as? CountryDetailsCollectionViewCell
        if let country = countryToDisplay {
            cell?.setup(imageString: country.images[indexPath.row])
        }
        cell?.backgroundColor = .blue
        return cell ?? UICollectionViewCell()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: imagesCollectionView.frame.width, height: imagesCollectionView.frame.height)

    }
}

extension CountryDetailsViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        imagesPageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

// MARK: - UITableViewDataSource

extension CountryDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
        withIdentifier: String(describing: InformationCell.self), for: indexPath
    ) as? InformationCell
        guard let countryToDisplay = countryToDisplay else {
            return  UITableViewCell()
        }
        cell?.setup(index: indexPath.row, country: countryToDisplay)

        return cell ?? UITableViewCell()
    }

}
