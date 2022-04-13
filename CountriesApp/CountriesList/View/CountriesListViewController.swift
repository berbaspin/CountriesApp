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
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Countries", comment: "")
        let countryCellNib = UINib(nibName: String(describing: CountryCell.self), bundle: nil)
        countriesTableView.register(countryCellNib, forCellReuseIdentifier: String(describing: CountryCell.self))

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        countriesTableView.refreshControl = refreshControl
    }

    @objc
    private func refreshData() {
        presenter.getLatestCountries()
        refreshControl.endRefreshing()
    }

    func setMoreCountries(_ countries: [CountryViewData]) {
        countriesTableView.tableFooterView = nil
        countriesToDisplay += countries
        countriesTableView.reloadData()
        self.isLoading = false
    }

    func setLatestCountries(_ countries: [CountryViewData]) {
        countriesToDisplay = countries
        countriesTableView.reloadData()
        self.isLoading = false
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

// MARK: - FooterExtentsion

extension CountriesListViewController {
    private func createSpinerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))

        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()

        return footerView
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y

        guard offsetY > (countriesTableView.contentSize.height - scrollView.frame.size.height) else {
            return
        }
        if isLoading {
            countriesTableView.tableFooterView = createSpinerFooter()
        } else {
            countriesTableView.tableFooterView = nil
        }
        presenter.getMoreCountries()
    }
}
