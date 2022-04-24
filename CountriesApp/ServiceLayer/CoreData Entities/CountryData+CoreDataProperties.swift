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
        NSFetchRequest<CountryData>(entityName: "CountryData")
    }

    @NSManaged var name: String? // а можно ли лучше?
    @NSManaged var continent: String?
    @NSManaged var capital: String?
    @NSManaged var population: Int32
    @NSManaged var smallDescription: String?
    @NSManaged var longDescription: String?
    @NSManaged var flag: String?
    @NSManaged var images: NSSet?

}

// MARK: Generated accessors for images
public extension CountryData {

    @objc(addImagesObject:) // узнать, зачем эта строка?
    @NSManaged func addToImages(_ value: CountryImages)

    @objc(removeImagesObject:)
    @NSManaged func removeFromImages(_ value: CountryImages)

    @objc(addImages:)
    @NSManaged func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged func removeFromImages(_ values: NSSet)

}

// Mark; Identifiable

extension CountryData: Identifiable {

}


extension CountryData {
    convenience init(country: Country) {
        self.init()
    }
}
