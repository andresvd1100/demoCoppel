//
//  MoviesInteractor.swift
//  testNoStory
//
//  Created by Andres Valerio on 13/02/23.
//  

import Foundation
import TMDBSwift

protocol MoviesInteractorProtocol {
    var movies : [Movie] {get set}
    func fetchToGetMovieList(type: Int, onSuccess: @escaping() -> Void)
}

class MoviesInteractor {
    private let dataManager: MoviesDataManagerProtocol
    private var moviesList: [Movie]
    
    init(dataManager: MoviesDataManagerProtocol) {
        self.dataManager = dataManager
        moviesList = []
    }
}

extension MoviesInteractor: MoviesInteractorProtocol {
    var movies: [Movie] {
        get {
            moviesList
        }
        set {
            moviesList = newValue
        }
    }
    
    
    func fetchToGetMovieList(type: Int, onSuccess: @escaping () -> Void) {
        dataManager.fetchToGetMoviesListTopRated(type: type) { movies in
            self.moviesList = movies
            onSuccess()
        } onError: { err in
            print("\(err)")
        }

    }
}

