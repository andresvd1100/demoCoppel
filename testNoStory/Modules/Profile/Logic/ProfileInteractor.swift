//
//  ProfileInteractor.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//  

import Foundation

protocol ProfileInteractorProtocol {
    var movies: [Movie] { get set}
    func fetchToGetMovies(onSuccess: @escaping() -> Void, onError: @escaping(Error) -> Void)
}

class ProfileInteractor {
    private let dataManager: ProfileDataManagerProtocol
    private var moviesSaved: [Movie] = []
    init(dataManager: ProfileDataManagerProtocol) {
        self.dataManager = dataManager
    }
}

extension ProfileInteractor: ProfileInteractorProtocol {
    var movies: [Movie] {
        get{
            return moviesSaved
        }
        set{
            self.moviesSaved = newValue
        }
    }
    
    func fetchToGetMovies(onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        dataManager.retrieveMoviesFromDB { moviesResult in
            self.movies = moviesResult
        } onError: { error in
            onError(error)
        }

    }
    
}

