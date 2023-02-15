//
//  LoginDataManager.swift
//  testNoStory
//
//  Created by Andres Valerio on 10/02/23.
//  

import Foundation

typealias LoginBadResponse = [String: String]

protocol LoginDataManagerProtocol {
    func fetchToLoginService(user: String, pass: String, onSuccess: @escaping (LoginResponse) -> Void, onBadResponse: @escaping (LoginBadResponse) -> Void, onError: @escaping (Error) -> Void)
}

class LoginDataManager: Request {
    
}

extension LoginDataManager: LoginDataManagerProtocol {
    func fetchToLoginService(user: String, pass: String, onSuccess: @escaping (LoginResponse) -> Void, onBadResponse: @escaping (LoginBadResponse) -> Void, onError: @escaping (Error) -> Void) {
        let endpoint = Services.authRequestToken
        Singleton.shared.email = user
        makeRequest(endpoint: endpoint, headers: ["api_key":Constants.TMDB.apiKey], model: LoginResponse.self) { response in
            print("\(response)")
            let params = [
                "username": user,
                "password": pass,
                "request_token": response.requestToken
            ]
            self.makeRequestPost(endpoint: Services.validateWithLogin, headers: ["api_key" : Constants.TMDB.apiKey], params: params, model: LoginResponse.self) { response in
                if(response.success){
                    onSuccess(response)
                }else{
                    onBadResponse(["error": response.statusMessage ?? ""])
                }
            } errorCompletion: { error in
                print("\(error)")
            }

        } errorCompletion: { error in
            print("\(error)")
        }

    }
}
