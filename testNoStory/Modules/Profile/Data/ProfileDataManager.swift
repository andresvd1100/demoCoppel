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
                MovieMDB.movie(movieID: Int(id.movie_id)) { clientReturn, data in
                    movies.append(Movie(id: data?.id, title: data?.title, releaseDate: data?.release_date, popularity: data?.popularity, overview: data?.overview, posterPath: String(format: "%@%@", Services.getBaseURLImages(),data?.poster_path ?? "")))
                }
            }
            onSuccess(movies)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            onError(error)
        }
    }
    
    
}
