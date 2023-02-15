//
//  MoviesModule.swift
//  testNoStory
//
//  Created by Andres Valerio on 13/02/23.
//  

import Foundation
import UIKit

final class MoviesModule {
    private let presenter: MoviesPresenterProtocol
    
    init(baseViewController: UIViewController) {
        let interactor = MoviesInteractor(dataManager: MoviesDataManager())
        let router = MoviesRouter(baseViewController: baseViewController)
        presenter = MoviesPresenter(interactor: interactor, router: router)
    }
    
    func showScreen() {
        return presenter.showScreen()
    }
}
