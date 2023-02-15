//
//  MoviesRouter.swift
//  testNoStory
//
//  Created by Andres Valerio on 13/02/23.
//  

import Foundation
import UIKit

protocol MoviesRouterProtocol {
    func showScreen(presenter: MoviesPresenterProtocol)
    func openMovieDetail(movie: Movie)
    func openProfile()
}

class MoviesRouter {
    private weak var baseController: UIViewController?
    private weak var module: MoviesViewController?
    
    init(baseViewController: UIViewController) {
        baseController = baseViewController
    }
}

extension MoviesRouter: MoviesRouterProtocol {
    func showScreen(presenter: MoviesPresenterProtocol) {
        guard let controller = baseController as? UINavigationController else { return }
        let viewController = MoviesViewController(presenter: presenter)
        controller.pushViewController(viewController, animated: true)
    }
    
    func openMovieDetail(movie: Movie) {
        guard let controller = baseController as? UINavigationController else { return }
        let module = MovieDetailModule(baseViewController: controller, movie: movie)
        module.showScreen()
    }
    
    func openProfile() {
        guard let controller = baseController as? UINavigationController else { return }
        let module = ProfileModule(baseViewController: controller)
        module.showScreen()
    }
}
