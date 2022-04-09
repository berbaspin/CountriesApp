//
//  CountryDetailsViewController.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 06.04.2022.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var imagesPageControl: UIPageControl!
    @IBOutlet weak var informationTableView: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var presenter: CountryDetailsPresenterProtocol!
    private var countryToDisplay: CountryViewData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setCountry()
        imagesCollectionView.register(UINib(nibName: String(describing: CountryDetailsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CountryDetailsCollectionViewCell.self))
        informationTableView.register(UINib(nibName: String(describing: InformationCell.self), bundle: nil), forCellReuseIdentifier: String(describing: InformationCell.self))
        imagesPageControl.numberOfPages = countryToDisplay?.images.count ?? 0
        nameLabel.text = countryToDisplay?.name
        descriptionLabel.text = countryToDisplay?.description
    }
    
}

extension CountryDetailsViewController: CountryDetailViewProtocol {
    func setCountry(country: CountryViewData?) {
        countryToDisplay = country
    }
}


extension CountryDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countryToDisplay?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CountryDetailsCollectionViewCell.self), for: indexPath) as! CountryDetailsCollectionViewCell
        if let country = countryToDisplay {
            cell.setup(imageString: country.images[indexPath.row])
        } 
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imagesCollectionView.frame.width, height: imagesCollectionView.frame.height)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        imagesPageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}

extension CountryDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InformationCell.self), for: indexPath) as! InformationCell
        
        switch (indexPath.row) {
        case 0:
            cell.fieldImage.image = UIImage(systemName: "star")
            cell.fieldLabel.text = "Capital"
            cell.countryDetailLabel.text = countryToDisplay?.capital
        case 1:
            cell.fieldImage.image = UIImage(systemName: "face.smiling")
            cell.fieldLabel.text = "Population"
            cell.countryDetailLabel.text = countryToDisplay?.population
        case 2:
            cell.fieldImage.image = UIImage(systemName: "globe.asia.australia")
            cell.fieldLabel.text = "Continent"
            cell.countryDetailLabel.text = countryToDisplay?.continent
        default:
            cell.fieldLabel.text = "???"
        }
        
        return cell
    }
    
    
}
