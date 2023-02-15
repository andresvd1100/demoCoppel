//
//  Services.swift
//  testNoStory
//
//  Created by Andres Valerio on 11/02/23.
//

import Foundation

class Services {
    static var authRequestToken: String{
        return String(format: "%@/authentication/token/new", getBaseURL())
    }
    
    static var validateWithLogin: String{
        return String(format: "%@/authentication/token/validate_with_login", getBaseURL())
    }
}


extension Services {
    static func getBaseURL() -> String {
        return "https://api.themoviedb.org/3"
    }
    
    static func getBaseURLImages() -> String {
        return "https://image.tmdb.org/t/p/original"
    }
}
