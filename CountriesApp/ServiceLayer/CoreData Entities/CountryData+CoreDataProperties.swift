//
//  CountryData+CoreDataProperties.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 20.04.2022.
//
//
import CoreData
import Foundation

public extension CountryData {

    @nonobjc
    class func fetchRequest() -> NSFetchRequest<CountryData> {
        NSFetchRequest<CountryData>(entityName: String(describing: CountryData.self))
    }

    @NSManaged var name: String
    @NSManaged var continent: String
    @NSManaged var capital: String
    @NSManaged var population: Int32
    @NSManaged var smallDescription: String?
    @NSManaged var longDescription: String?
    @NSManaged var flag: String
    @NSManaged var images: NSSet?

}

// MARK: - Identifiable

extension CountryData: Identifiable {

}

extension CountryData {
    convenience init(context: NSManagedObjectContext, country: Country) {
        self.init(context: context)
        name = country.name
        continent = country.continent
        capital = country.capital
        population = Int32(country.population)
        smallDescription = country.descriptionSmall
        longDescription = country.description
        flag = country.countryInfo.flag
    }
}
