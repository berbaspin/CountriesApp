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

class CoreDataManager: CoreDataManagerProtocol {
    // MARK: - Core Data stack

    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CountriesApp")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: - Core Data Saving support

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func saveCountry(country: Country) {
        guard !isEntityAttributeExist(name: country.name, entityName: "CountryData") else {
            return
        }

        let newCountry = CountryData(context: viewContext)
        newCountry.name = country.name
        newCountry.continent = country.continent
        newCountry.capital = country.capital
        newCountry.population = Int32(country.population)
        newCountry.smallDescription = country.descriptionSmall
        newCountry.longDescription = country.description
        newCountry.flag = country.countryInfo.flag
        var images = country.countryInfo.images
        images.append(country.image)
        newCountry.images = NSSet(array: saveImages(country: newCountry, images: images))

        saveContext()
    }

    private func saveImages(country: CountryData, images: [String]) -> [CountryImages] {
        var addedImages = [CountryImages]()
        for image in images {
            let newImage = CountryImages(context: viewContext)
            newImage.country = country
            newImage.imageUrl = image
            addedImages.append(newImage)
        }
        return addedImages
    }

    func getCountries() -> [CountryData] {
        let fetchRequest: NSFetchRequest<CountryData> = CountryData.fetchRequest()

        do {
            return try viewContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Failed to fetch data from Core Data: \(error.localizedDescription)")
            return []
        }
    }

    private func isEntityAttributeExist(name: String, entityName: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let result = try viewContext.fetch(fetchRequest)
            return result.isEmpty ? false : true
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
    }
}
