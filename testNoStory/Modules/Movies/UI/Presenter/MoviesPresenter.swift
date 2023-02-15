//
//  MoviesPresenter.swift
//  testNoStory
//
//  Created by Andres Valerio on 13/02/23.
//  

import Foundation
import UIKit
import TMDBSwift

protocol MoviesPresenterProtocol {
    var movies: [Movie] { get }
    func showScreen()
    func setViewProtocol(view: MoviesViewControllerProtocol)
    func prepareForGetMovieList(type: Int)
    func prepareForMovieDetail(movie: Movie)
    func prepareForProfile()
}

class MoviesPresenter {
    private weak var viewProtocol: MoviesViewControllerProtocol?
    private let interactor: MoviesInteractorProtocol
    private let router: MoviesRouterProtocol
    
    init(interactor: MoviesInteractorProtocol, router: MoviesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MoviesPresenter: MoviesPresenterProtocol {
    var movies: [Movie] {
        interactor.movies
    }
    
    func showScreen() {
        return router.showScreen(presenter: self)
    }
    
    func setViewProtocol(view: MoviesViewControllerProtocol) {
        viewProtocol = view
    }
    
    func prepareForGetMovieList(type: Int) {
        interactor.fetchToGetMovieList(type: type) {
            DispatchQueue.main.async { [weak self] in
                self?.viewProtocol?.updateView()
            }
        }
    }
    
    func prepareForMovieDetail(movie: Movie) {
        router.openMovieDetail(movie: movie)
    }
    
    func prepareForProfile() {
        router.openProfile()
    }
}
