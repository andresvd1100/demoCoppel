//
//  ProfileDataManager.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//  

import Foundation
import TMDBSwift
import CoreData

protocol ProfileDataManagerProtocol {
    func retrieveMoviesFromDB(onSuccess: @escaping([Movie]) -> Void, onError: @escaping(Error) -> Void)
}

class ProfileDataManager {
    
}

extension ProfileDataManager: ProfileDataManagerProtocol {
    func retrieveMoviesFromDB(onSuccess: @escaping ([Movie]) -> Void, onError: @escaping(Error) -> Void) {
        let favoritesFetch: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        var ids: [Favorites] = []
        var movies: [Movie] = []
        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try managedContext.fetch(favoritesFetch)
            ids = results
            
            for id in ids{
                movies.append(Movie(id: Int(id.movie_id ?? "0"), title: id.title, releaseDate: id.release_date, popularity: Double(id.rate ?? "0.0"), overview: id.overview, posterPath: id.path))
            }
            onSuccess(movies)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            onError(error)
        }
    }
    
    
}
