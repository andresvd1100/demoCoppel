//
//  LoginPresenter.swift
//  testNoStory
//
//  Created by Andres Valerio on 10/02/23.
//  

import Foundation
import UIKit

protocol LoginPresenterProtocol {
    func showScreen()
    func showScreenW()
    func setViewProtocol(view: LoginViewControllerProtocol)
    func prepareForLogin(user: String, password: String)
}

class LoginPresenter {
    private weak var viewProtocol: LoginViewControllerProtocol?
    private let interactor: LoginInteractorProtocol
    private let router: LoginRouterProtocol
    
    init(interactor: LoginInteractorProtocol, router: LoginRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension LoginPresenter: LoginPresenterProtocol {

    
    func showScreen() {
        return router.showScreen(presenter: self)
    }
    
    func showScreenW() {
        return router.showScreenW(presenter: self)
    }
    
    func setViewProtocol(view: LoginViewControllerProtocol) {
        viewProtocol = view
    }
    
    func prepareForLogin(user: String, password: String) {
        interactor.fetchToLoginService(username: user, password: password) {
            DispatchQueue.main.async { [weak self] in
                self?.router.openMoviesView()
            }
        } onError: { error in
            print("Error")
            DispatchQueue.main.async { [weak self] in
                self?.viewProtocol?.updateWithError(errorMessage: error)
            }
        }

    }
}
