//
//  ViewController.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 04.04.2022.
//

import UIKit

class CountriesListViewController: UIViewController, CountriesListViewProtocol {
    
    @IBOutlet weak var countriesTableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    var presenter: CountriesListPresenterProtocol!
    private var countriesToDisplay = [CountryViewData]()
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Countries"
        let countryCellNib = UINib(nibName: String(describing: CountryCell.self), bundle: nil)
        countriesTableView.register(countryCellNib, forCellReuseIdentifier: String(describing: CountryCell.self))
        
        
        refreshControl.addTarget(self, action: #selector(someFunc), for: .valueChanged)
        countriesTableView.refreshControl = refreshControl
    }
    
    @objc func someFunc() {
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
        countriesToDisplay.insert(country, at: 0)
        countriesTableView.reloadData()
    }
}

extension CountriesListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countriesToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryCell.self), for: indexPath) as! CountryCell
        let countryViewData = countriesToDisplay[indexPath.row]
        cell.setup(country: countryViewData)
        return cell
        
    }
    
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
        
        if offsetY > (countriesTableView.contentSize.height - scrollView.frame.size.height) {
            if isLoading {
                countriesTableView.tableFooterView = createSpinerFooter()
            } else {
                countriesTableView.tableFooterView = nil
            }
            
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

