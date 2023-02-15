//
//  ProfilePresenter.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//  

import Foundation
import UIKit

protocol ProfilePresenterProtocol {
    var movies: [Movie] { get }
    func showScreen()
    func setViewProtocol(view: ProfileViewControllerProtocol)
    func prepareForGetMovies()
    func prepareForCloseSession()
}

class ProfilePresenter {
    private weak var viewProtocol: ProfileViewControllerProtocol?
    private let interactor: ProfileInteractorProtocol
    private let router: ProfileRouterProtocol
    
    init(interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
    var movies: [Movie] {
        get{
            interactor.movies
        }
    }
    
    func showScreen() {
        return router.showScreen(presenter: self)
    }
    
    func setViewProtocol(view: ProfileViewControllerProtocol) {
        viewProtocol = view
    }
    
    func prepareForGetMovies() {
        interactor.fetchToGetMovies {
            DispatchQueue.main.async { [weak self] in
                self?.viewProtocol?.updateView()
            }
        } onError: { error in
            print("\(error)")
        }

    }
    
    func prepareForCloseSession() {
        router.logOut()
    }
    
}
