//
//  ViewController.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 04.04.2022.
//

import UIKit

final class CountriesListViewController: UIViewController {

    @IBOutlet private var countriesTableView: UITableView!
    private let refreshControl = UIRefreshControl()
    // swiftlint:disable:next implicitly_unwrapped_optional
    var presenter: CountriesListPresenterProtocol!
    private var isSpinnerShown = false
    private var countriesToDisplay = [CountryViewData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let index = self.countriesTableView.indexPathForSelectedRow else {
            return
        }

        self.countriesTableView.deselectRow(at: index, animated: true)
    }
}

// MARK: - Setup methods

private extension CountriesListViewController {
    func setup() {
        self.title = "Countries".localized()
        let countryCellNib = UINib(nibName: String(describing: CountryCell.self), bundle: nil)
        countriesTableView.register(countryCellNib, forCellReuseIdentifier: String(describing: CountryCell.self))

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        countriesTableView.refreshControl = refreshControl

        let spinnerFooter = SpinnerView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        countriesTableView.tableFooterView = spinnerFooter
    }

    @objc
    func refreshData() {
        presenter.getLatestCountries()
        refreshControl.endRefreshing()
    }
}

// MARK: - CountriesListViewProtocol

extension CountriesListViewController: CountriesListViewProtocol {
    func setCountries(_ countries: [CountryViewData], showPagination: Bool) {
        isSpinnerShown = showPagination
        countriesToDisplay = countries
        countriesTableView.reloadData()
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
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == countriesToDisplay.count - 1  else {
            return
        }
      tableView.tableFooterView?.isHidden = !isSpinnerShown // isSpinnerHidden

        if isSpinnerShown {
            presenter.getMoreCountries()
        }
    }
}
