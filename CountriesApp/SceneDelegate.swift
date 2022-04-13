//
//  SceneDelegate.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 04.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        let assemblyBuilder = AssenlyBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        router.initializeViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}
