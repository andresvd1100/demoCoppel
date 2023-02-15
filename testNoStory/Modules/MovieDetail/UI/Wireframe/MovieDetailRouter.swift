//
//  MovieDetailRouter.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//  

import Foundation
import UIKit

protocol MovieDetailRouterProtocol {
    func showScreen(presenter: MovieDetailPresenterProtocol)
}

class MovieDetailRouter {
    private weak var baseController: UIViewController?
    private weak var module: MovieDetailViewController?
    
    init(baseViewController: UIViewController) {
        baseController = baseViewController
    }
}

extension MovieDetailRouter: MovieDetailRouterProtocol {
    func showScreen(presenter: MovieDetailPresenterProtocol) {
        guard let controller = baseController as? UINavigationController else { return }
        let viewController = MovieDetailViewController(presenter: presenter)
        controller.pushViewController(viewController, animated: true)
    }
}
