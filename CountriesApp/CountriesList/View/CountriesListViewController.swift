//
//  ViewController.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 04.04.2022.
//

import UIKit

class CountriesListViewController: UIViewController, CountriesListViewProtocol {

    @IBOutlet weak var countriesTableView: UITableView! // weak не надо. Все свойства приватные
    private let refreshControl = UIRefreshControl()

    var presenter: CountriesListPresenterProtocol!
    private var countriesToDisplay = [CountryViewData]()
    var isLoading = false // это должно быть в презентере

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Countries" // Я бы добавил NSLocalizedString просто чтобы показать что ты знаешь что это
        let countryCellNib = UINib(nibName: String(describing: CountryCell.self), bundle: nil)
        countriesTableView.register(countryCellNib, forCellReuseIdentifier: String(describing: CountryCell.self))

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        countriesTableView.refreshControl = refreshControl
    }

    @objc private func refreshData() {
        presenter.getOneCountry(numberOfCountries: countriesToDisplay.count)
        refreshControl.endRefreshing()
    }

    func setCountries(_ countries: [CountryViewData]) {
        countriesTableView.tableFooterView = nil
        countriesToDisplay = countries
        countriesTableView.reloadData()
        isLoading = false
    }

    func setOneCountry(_ country: CountryViewData) {
        countriesToDisplay.insert(country, at: 0) // на звонке обсудим. Я не понял) Типа имитация pull to refresh?
        countriesTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource // покажу как этим пользоваться в xcode

extension CountriesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countriesToDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryCell.self), for: indexPath) as? CountryCell
        let countryViewData = countriesToDisplay[indexPath.row]
        cell?.setup(country: countryViewData)
        return cell ?? UITableViewCell()
    }

    private func createSpinerFooter() -> UIView { // это не относится к UITAbleViewDataSource, убирай в отдельный экстеншн
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))

        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center // а если телефон повернуть, acitivity indicator останется по центру?
        footerView.addSubview(spinner)
        spinner.startAnimating()

        return footerView
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) { // опять же, это не UITableViewDataSource
        let offsetY = scrollView.contentOffset.y

        if offsetY > (countriesTableView.contentSize.height - scrollView.frame.size.height) {// guard
            if isLoading {
                countriesTableView.tableFooterView = createSpinerFooter()
            } else {
                countriesTableView.tableFooterView = nil
            }
          //  countriesTableView.tableFooterView = createSpinerFooter() // где-то наверху
          // countriesTableView.isHidden = !isLoading // здесь
          // создавать view дорого, лучше переиспользовать

            presenter.getCountries()
        }
    }

}

extension CountriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countriesToDisplay[indexPath.row]
        presenter.tapOnCountry(country: country)
    }
}
