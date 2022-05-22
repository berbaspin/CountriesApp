//
//  CoreDataManager.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 19.04.2022.
//

import CoreData
import Foundation

protocol CoreDataManagerProtocol {
    func saveCountry(country: Country)
    func getCountries() -> [CountryData]
}

final class CoreDataManager: CoreDataManagerProtocol {
    private let modelName = "CountriesApp"
    private let persistentStoreDescriptionType: String

    init(persistentStoreDescriptionType: String = NSSQLiteStoreType) {
        self.persistentStoreDescriptionType = persistentStoreDescriptionType
    }
    // MARK: - Core Data stack

    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = persistentStoreDescriptionType

        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            guard let error = error else {
                return
            }
            print("Unresolved error \(error)")
        }
        return container
    }()

    // MARK: - Core Data Saving support

    private func saveContext () {
        let context = persistentContainer.viewContext
        guard context.hasChanges else {
            return
        }
        do {
            try context.save()
        } catch {
            print("Unresolved error \(error.localizedDescription)")
        }

    }

    func saveCountry(country: Country) {
        guard !isEntityAttributeValueExist(name: country.name, entityName: String(describing: CountryData.self)) else {
            return
        }

        let newCountry = CountryData(context: viewContext, country: country)
        let images = country.countryInfo.images + [country.image]
        newCountry.images = NSSet(array: saveImages(country: newCountry, images: images))
        saveContext()
    }

    private func saveImages(country: CountryData, images: [String]) -> [CountryImages] {
        images.map { image -> CountryImages in
            CountryImages(context: viewContext, country: country, imageUrl: image)
        }
    }

    func getCountries() -> [CountryData] {
        let fetchRequest: NSFetchRequest<CountryData> = CountryData.fetchRequest()

        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch data from Core Data: \(error.localizedDescription)")
            return []
        }
    }

    private func isEntityAttributeValueExist(name: String, entityName: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let result = try viewContext.fetch(fetchRequest)
            return !result.isEmpty
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
