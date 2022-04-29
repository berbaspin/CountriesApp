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
    func deleteAllCountries()
    func deleteAllImages()
}

final class CoreDataManager: CoreDataManagerProtocol {
    // MARK: - Core Data stack

    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CountriesApp")
        container.loadPersistentStores { _, error in
            guard let error = error as NSError? else {
                return
            }
            fatalError("Unresolved error \(error), \(error.userInfo)")
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
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }

    }

    func saveCountry(country: Country) {
        guard !isEntityAttributeExist(name: country.name, entityName: "CountryData") else {
            return
        }

        let newCountry = CountryData(context: viewContext, country: country)
        var images = country.countryInfo.images
        images.append(country.image)
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

    private func isEntityAttributeExist(name: String, entityName: String) -> Bool {
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

    func deleteAllCountries() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CountryData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteAllImages() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CountryImages")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}
