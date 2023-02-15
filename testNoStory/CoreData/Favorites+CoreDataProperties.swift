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

    @NSManaged public var movie_id: Int16

}

extension Favorites : Identifiable {

}
