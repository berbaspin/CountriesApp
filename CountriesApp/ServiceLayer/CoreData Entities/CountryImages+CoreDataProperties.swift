//
//  CountryImages+CoreDataProperties.swift
//  CountriesApp
//
//  Created by Dmitry Babaev on 20.04.2022.
//
//

import CoreData
import Foundation

public extension CountryImages {

    @NSManaged var imageUrl: String
    @NSManaged var country: CountryData

}

// MARK: - Identifiable

extension CountryImages: Identifiable {

}

extension CountryImages {
    convenience init(context: NSManagedObjectContext, country: CountryData, imageUrl: String) {
        self.init(context: context)
        self.country = country
        self.imageUrl = imageUrl
    }
}
