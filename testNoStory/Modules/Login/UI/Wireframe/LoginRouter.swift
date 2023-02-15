//
//  LoginRouter.swift
//  testNoStory
//
//  Created by Andres Valerio on 10/02/23.
//  

import Foundation
import UIKit

protocol LoginRouterProtocol {
    func showScreen(presenter: LoginPresenterProtocol)
    func showScreenW(presenter: LoginPresenterProtocol)
    func openMoviesView()
}

class LoginRouter {
    private weak var baseController: UIViewController?
    private weak var module: LoginViewController?
    private weak var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    init(baseViewController: UIViewController) {
        baseController = baseViewController
    }
}

extension LoginRouter: LoginRouterProtocol {
    func showScreen(presenter: LoginPresenterProtocol) {
        guard let controller = baseController as? UINavigationController else { return }
        let viewController = LoginViewController(presenter: presenter)
        controller.pushViewController(viewController, animated: true)
    }
    
    func showScreenW(presenter: LoginPresenterProtocol) {
        guard let window = window else { return  }
        let viewController = LoginViewController(presenter: presenter)
        let navigation = UINavigationController(rootViewController: viewController)
        baseController = navigation
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        
    }
    
    func openMoviesView() {
        guard let navigation = baseController as? UINavigationController else { return }
        Utils.changeRootViewControllerWith(controller: navigation)
        let controller = MoviesModule(baseViewController: navigation)
        controller.showScreen()
    }
}
