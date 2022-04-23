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

    @nonobjc
    class func fetchRequest() -> NSFetchRequest<CountryImages> {
        NSFetchRequest<CountryImages>(entityName: "CountryImages")
    }

    @NSManaged var imageUrl: String?
    @NSManaged var country: CountryData?

}

extension CountryImages: Identifiable {

}
