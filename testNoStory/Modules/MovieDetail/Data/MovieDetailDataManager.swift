//
//  MovieDetailDataManager.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//  

import Foundation
import TMDBSwift

protocol MovieDetailDataManagerProtocol {
    func getDiscoverData(movie: Movie, onScucess: @escaping(DiscoverMovie)-> Void, onError: (Error) -> Void)
    func getCrew(movie: Movie, onSuccess: @escaping([String: [Crew]]) -> Void, onError: (Error) -> Void)
    func saveToFavorites(movie: Movie, onSuccess: @escaping(Bool) -> Void )
}

class MovieDetailDataManager {
    
}

extension MovieDetailDataManager: MovieDetailDataManagerProtocol {
    func getDiscoverData(movie: Movie, onScucess: @escaping (DiscoverMovie) -> Void, onError: (Error) -> Void) {
        MovieMDB.movie(movieID: movie.id,language: "es") { clientReturn, data in
            let movieDetail = DiscoverMovie()
            movieDetail.title = data?.title
            movieDetail.duration = data?.runtime?.getDuration()
            let arrayGenres = data?.genres.map({ (id: Int?, name: String?) -> String in
                String().appending(name ?? "")
            })
            movieDetail.genres = arrayGenres?.joined(separator: ",")
            movieDetail.status = data?.status
            movieDetail.revenue = data?.revenue?.getCurrencyFormat()
            movieDetail.budget = data?.budget?.getCurrencyFormat()
            movieDetail.dateRelease = data?.release_date
            onScucess(movieDetail)
        }
    }
    
    func getCrew(movie: Movie, onSuccess: @escaping ([String : [Crew]]) -> Void, onError: (Error) -> Void) {
        MovieMDB.credits(movieID: movie.id) { clientReturn, credits in
            if let credits = credits{
                var mCrew: [Crew] = []
                var mCast: [Crew] = []
                for crew in credits.crew{
                    mCrew.append(Crew(name: crew.name, character: crew.department, imagePath: String(format: "%@%@", Services.getBaseURLImages(),crew.profile_path ?? "")))
                }
                for cast in credits.cast{
                    mCast.append(Crew(name: cast.name, character: cast.character, imagePath: String(format: "%@%@", Services.getBaseURLImages(),cast.profile_path ?? "")))
                }
                let people = ["cast":mCast,"crew":mCrew]
                onSuccess(people)
            }
        }
    }
    
    func saveToFavorites(movie: Movie, onSuccess: @escaping (Bool) -> Void) {
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let newFavorites = Favorites(context: managedContext)
        newFavorites.setValue(movie.id, forKey: #keyPath(Favorites.movie_id))
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        onSuccess(true)
    }
}
