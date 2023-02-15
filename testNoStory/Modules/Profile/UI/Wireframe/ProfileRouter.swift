//
//  ProfileRouter.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//  

import Foundation
import UIKit

protocol ProfileRouterProtocol {
    func showScreen(presenter: ProfilePresenterProtocol)
}

class ProfileRouter {
    private weak var baseController: UIViewController?
    private weak var module: ProfileViewController?
    
    init(baseViewController: UIViewController) {
        baseController = baseViewController
    }
}

extension ProfileRouter: ProfileRouterProtocol {
    func showScreen(presenter: ProfilePresenterProtocol) {
        guard let controller = baseController as? UINavigationController else { return }
        let viewController = ProfileViewController(presenter: presenter)
        controller.pushViewController(viewController, animated: true)
    }
}
