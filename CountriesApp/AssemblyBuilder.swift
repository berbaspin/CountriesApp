//
//  AssemblyBuilder.swift
//  CountriesApp
//
//  Created by Дмитрий Бабаев on 05.04.2022.
//  Поменяй имя пользователя в macos на английском, чтобы подписи в файлах сверху были на английском
//  1) если после после запуска делать pull to refresh, то добавляются сверху новые страны,
//  пока не дойдет до Израиля. Выглядит похоже на баг. После этого пагинация ломается
//  2) Синий плейсхолдер вместо фотографии - плохой вариант (в детальном экране), выглядит похоже на баг
//  3) Если картинка не грузится то получается две синих картинки, кажется что horizontal скролл не работает; Я помню что АПИ плохо работает, но надо придумать как спрятать или поменять АПИ. Выглядит как твой косяк для постороннего человека
//  4) После выбора ячейки и возврата на экран ячейка остается выбранной
//  5) Если фотка в деталях одна, возможно индикатор текущей фотки стоит прятать (он не имеет смысла)ё
//  6) На сфейлившеся фотки в таблице надо ставить плейсхолдер. На загрузку можно поставить activity indicator
//  7) gitignore добавил для себя чтобы всякие DS_Store не лезли в гит

import UIKit

protocol AssemblyBuilderProtocol {
    func createCoutriesListModule(router: RouterProtocol) -> UIViewController
    func createCountryDetailsModule(country: CountryViewData?, router: RouterProtocol) -> UIViewController
}

class AssenlyBuilder: AssemblyBuilderProtocol {
    func createCoutriesListModule(router: RouterProtocol) -> UIViewController {
        let view = CountriesListViewController() // не критично, но называть view ViewController не надо
        let networkService = NetworkService()
        let dataFetcher = NetworkDataFetcher(networkService: networkService)
        let presenter = CountriesListPresenter(view: view, dataFetcher: dataFetcher, router: router)
        view.presenter = presenter
        return view
    }

    // Может ли детальный экран быть показан со страной равной nil? Если нет, то не нужно передавать опшинал
    func createCountryDetailsModule(country: CountryViewData?, router: RouterProtocol) -> UIViewController {
        let view = CountryDetailsViewController() // не критично, но называть view ViewController не надо
        let presenter = CountryDetailsPresenter(view: view, router: router, country: country)
        view.presenter = presenter
        return view
    }
}
