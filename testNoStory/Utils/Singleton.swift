//
//  Singleton.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//

import Foundation

class Singleton{
    static var shared: Singleton = Singleton()
    var email: String?
    
    func ereaseAll() {
        email = nil
    }
        
}
