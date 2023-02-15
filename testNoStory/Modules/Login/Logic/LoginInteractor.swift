//
//  LoginInteractor.swift
//  testNoStory
//
//  Created by Andres Valerio on 10/02/23.
//  

import Foundation

protocol LoginInteractorProtocol {
    func fetchToLoginService(username: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void)
        
}

class LoginInteractor {
    private let dataManager: LoginDataManagerProtocol
    
    init(dataManager: LoginDataManagerProtocol) {
        self.dataManager = dataManager
    }
}

extension LoginInteractor: LoginInteractorProtocol {
    
    func fetchToLoginService(username: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        dataManager.fetchToLoginService(user: username, pass: password) { response in
            onSuccess()
        } onBadResponse: { badresponse in
            onError(badresponse["error"] ?? "")
        } onError: { error in
            
        }

    }
}

