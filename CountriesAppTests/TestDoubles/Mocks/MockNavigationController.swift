//
//  MockNavigationController.swift
//  CountriesAppTests
//
//  Created by Dmitry Babaev on 19.05.2022.
//

import UIKit

final class MockNavigationController: UINavigationController {
    var presenterVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presenterVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
