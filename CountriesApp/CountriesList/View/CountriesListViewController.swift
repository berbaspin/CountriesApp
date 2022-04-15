//
//  ViewController.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 04.04.2022.
//

import UIKit

class CountriesListViewController: UIViewController, CountriesListViewProtocol {

    @IBOutlet private var countriesTableView: UITableView!
    private let refreshControl = UIRefreshControl()
    // swiftlint:disable:next implicitly_unwrapped_optional
    var presenter: CountriesListPresenterProtocol!
    private var countriesToDisplay = [CountryViewData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Countries".localized()
        let countryCellNib = UINib(nibName: String(describing: CountryCell.self), bundle: nil)
        countriesTableView.register(countryCellNib, forCellReuseIdentifier: String(describing: CountryCell.self))

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        countriesTableView.refreshControl = refreshControl
        countriesTableView.tableFooterView = createSpinerFooter()
    }

    @objc
    private func refreshData() {
        presenter.getLatestCountries()
        refreshControl.endRefreshing()
    }

    func setMoreCountries(_ countries: [CountryViewData], showPagination: Bool) {
        if !showPagination {
            countriesTableView.tableFooterView = nil
        }
        countriesToDisplay += countries
        countriesTableView.reloadData()

    }

    func setLatestCountries(_ countries: [CountryViewData]) {
        countriesToDisplay = countries
        countriesTableView.reloadData()
    }

    private func createSpinerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))

        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()

        return footerView
    }
}

// MARK: - UITableViewDataSource

extension CountriesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countriesToDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: CountryCell.self),
            for: indexPath
        ) as? CountryCell
        let countryViewData = countriesToDisplay[indexPath.row]
        cell?.setup(country: countryViewData)
        return cell ?? UITableViewCell()

    }
}

// MARK: - UITableViewDelegate

extension CountriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countriesToDisplay[indexPath.row]
        presenter.tapOnCountry(country: country)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - Pagination

extension CountriesListViewController {

    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let offsetY = scrollView.contentOffset.y

        guard offsetY > (countriesTableView.contentSize.height - scrollView.frame.size.height) else {
            return
        }
        presenter.getMoreCountries()
    }
}
