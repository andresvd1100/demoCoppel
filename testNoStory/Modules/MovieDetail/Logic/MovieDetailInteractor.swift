//
//  MovieDetailInteractor.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//  

import Foundation
import TMDBSwift

protocol MovieDetailInteractorProtocol {
    var detailMovie: DiscoverMovie? { get set }
    var movies: Movie { get }
    var crew: [Crew]? { get set }
    var cast: [Crew]? { get set }
    func fetchToGetDataMovie(onSuccess: @escaping() -> Void)
    func fetchToGetCrew(onSuccess: @escaping() -> Void)
}

class MovieDetailInteractor {
    private let dataManager: MovieDetailDataManagerProtocol
    private let movie: Movie
    var discover: DiscoverMovie?
    var people: [Crew]?
    var workers: [Crew]?
    
    init(dataManager: MovieDetailDataManagerProtocol, movie: Movie) {
        self.dataManager = dataManager
        self.movie = movie
        self.discover = nil
        //getMovieDetail()
    }
    
}

extension MovieDetailInteractor: MovieDetailInteractorProtocol {
    var cast: [Crew]? {
        get {
            return people
        }
        set {
            people = newValue
        }
    }
    
    var crew: [Crew]? {
        get {
            return workers
        }
        set {
            workers = newValue
        }
    }
    
    
    
    var detailMovie: DiscoverMovie?{
        get{
            return discover
        }
        set{
            discover = newValue
        }
    }
    
    var movies: Movie{
        get{
            return movie
        }
    }
    
    func fetchToGetDataMovie(onSuccess: @escaping () -> Void) {
        dataManager.getDiscoverData(movie: self.movie) { discover in
            self.detailMovie = discover
            onSuccess()
        } onError: { error in
            print("\(error)")
        }
    }
    
    func fetchToGetCrew(onSuccess: @escaping () -> Void) {
        dataManager.getCrew(movie: self.movie) { responseCrew in
            self.crew = responseCrew["crew"]
            self.cast = responseCrew["cast"]
            onSuccess()
        } onError: { error in
            print("\(error)")
        }

    }
    
}

