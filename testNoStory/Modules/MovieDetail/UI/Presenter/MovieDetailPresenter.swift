//
//  MovieDetailPresenter.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//  

import Foundation
import UIKit

protocol MovieDetailPresenterProtocol {
    var detailMovie: DiscoverMovie?{ get }
    var movie: Movie { get }
    var crew: [Crew] { get }
    var cast: [Crew] { get }
    func showScreen()
    func setViewProtocol(view: MovieDetailViewControllerProtocol)
    func prepareFotGetDetailMovie()
    func prepareForGetCrew()
}

class MovieDetailPresenter {
    private weak var viewProtocol: MovieDetailViewControllerProtocol?
    private let interactor: MovieDetailInteractorProtocol
    private let router: MovieDetailRouterProtocol
    
    init(interactor: MovieDetailInteractorProtocol, router: MovieDetailRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    var cast: [Crew] {
        get{
            interactor.cast ?? []
        }
    }
    
    var crew: [Crew] {
        get{
            interactor.crew ?? []
        }
    }
    
    var detailMovie: DiscoverMovie? {
        get{
            interactor.detailMovie
        }
    }
    
    var movie: Movie{
        get{
            interactor.movies
            
        }
    }
    
    func showScreen() {
        return router.showScreen(presenter: self)
    }
    
    func setViewProtocol(view: MovieDetailViewControllerProtocol) {
        viewProtocol = view
    }
    
    func prepareFotGetDetailMovie() {
        interactor.fetchToGetDataMovie {
            DispatchQueue.main.async { [weak self] in
                self?.viewProtocol?.updateViewBasic()
            }
        }
    }
    
    func prepareForGetCrew() {
        interactor.fetchToGetCrew {
            DispatchQueue.main.async { [weak self] in
                self?.viewProtocol?.updateViewCrew()
            }
        }
    }
}
