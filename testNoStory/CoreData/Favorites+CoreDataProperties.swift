//
//  Favorites+CoreDataProperties.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var movie_id: String?
    @NSManaged public var path: String?
    @NSManaged public var overview: String?
    @NSManaged public var rate: String?
    @NSManaged public var title: String?
    @NSManaged public var release_date: String?

}

extension Favorites : Identifiable {

}
