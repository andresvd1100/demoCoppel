//
//  MovieDetailModule.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//  

import Foundation
import UIKit

final class MovieDetailModule {
    private let presenter: MovieDetailPresenterProtocol
    
    init(baseViewController: UIViewController, movie: Movie) {
        let interactor = MovieDetailInteractor(dataManager: MovieDetailDataManager(), movie: movie)
        let router = MovieDetailRouter(baseViewController: baseViewController)
        presenter = MovieDetailPresenter(interactor: interactor, router: router)
    }
    
    func showScreen() {
        return presenter.showScreen()
    }
}
