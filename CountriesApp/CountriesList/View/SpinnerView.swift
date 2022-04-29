//
//  SpinnerView.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 28.04.2022.
//

import UIKit

final class SpinnerView: UIView {
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
