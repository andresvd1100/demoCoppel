//
//  ProfileModule.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//  

import Foundation
import UIKit

final class ProfileModule {
    private let presenter: ProfilePresenterProtocol
    
    init(baseViewController: UIViewController) {
        let interactor = ProfileInteractor(dataManager: ProfileDataManager())
        let router = ProfileRouter(baseViewController: baseViewController)
        presenter = ProfilePresenter(interactor: interactor, router: router)
    }
    
    func showScreen() {
        return presenter.showScreen()
    }
}
