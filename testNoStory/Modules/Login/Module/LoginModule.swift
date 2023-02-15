//
//  LoginModule.swift
//  testNoStory
//
//  Created by Andres Valerio on 10/02/23.
//  

import Foundation
import UIKit

final class LoginModule {
    private let presenter: LoginPresenterProtocol
    
    init(baseViewController: UIViewController) {
        let interactor = LoginInteractor(dataManager: LoginDataManager())
        let router = LoginRouter(baseViewController: baseViewController)
        presenter = LoginPresenter(interactor: interactor, router: router)
    }
    
    init(window: UIWindow) {
        let interactor = LoginInteractor(dataManager: LoginDataManager())
        let router = LoginRouter(window: window)
        presenter = LoginPresenter(interactor: interactor, router: router)
    }
    
    func showScreen() {
        return presenter.showScreen()
    }
    
    func showScreenW(){
        return presenter.showScreenW()
    }
}
