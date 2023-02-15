//
//  MoviesDataManager.swift
//  testNoStory
//
//  Created by Andres Valerio on 13/02/23.
//  

import Foundation
import TMDBSwift

enum TypeList{
    case popular
    case topRated
    case onAir
    case upcoming
}

protocol MoviesDataManagerProtocol {
    func fetchToGetMoviesListTopRated(type: Int, onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void)
}

class MoviesDataManager {
    func convertMoviesMDBToMovies(movies: [MovieMDB], onSucess: @escaping([Movie]) -> Void) {
        let moviesModel: [Movie] = movies.map { mvs -> Movie in
            Movie.init(id: mvs.id, title: mvs.title, releaseDate: mvs.release_date, popularity: mvs.popularity, overview: mvs.overview, posterPath: String(format: "%@%@", Services.getBaseURLImages(),mvs.poster_path ?? ""))
        }
        onSucess(moviesModel)
    }
}

extension MoviesDataManager: MoviesDataManagerProtocol {
    func fetchToGetMoviesListTopRated(type: Int, onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void) {
        switch type{
        case 0:
            MovieMDB.popular(language: "es", page: 1, completion: { _, movies in
                let data: [MovieMDB]? = movies
                guard let movies = data else {
                    onError("No movies to show")
                    return  }
                self.convertMoviesMDBToMovies(movies: movies, onSucess: onSuccess)
            })
        case 1:
            MovieMDB.toprated(language: "es", page: 1, completion: { _, movies in
                let data: [MovieMDB]? = movies
                guard let movies = data else {
                    onError("No movies to show")
                    return  }
                self.convertMoviesMDBToMovies(movies: movies, onSucess: onSuccess)
            })
        case 2:
            MovieMDB.nowplaying(language: "es", page: 1, completion: { _, movies in
                let data: [MovieMDB]? = movies
                guard let movies = data else {
                    onError("No movies to show")
                    return  }
                self.convertMoviesMDBToMovies(movies: movies, onSucess: onSuccess)
            })
        case 3:
            MovieMDB.upcoming(page: 1, language: "es", completion: { _, movies in
                let data: [MovieMDB]? = movies
                guard let movies = data else {
                    onError("No movies to show")
                    return  }
                self.convertMoviesMDBToMovies(movies: movies, onSucess: onSuccess)
            })
            
        default:
            break
        }
        
    }
}
