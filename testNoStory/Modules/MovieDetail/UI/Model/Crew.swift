//
//  Crew.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//

import Foundation

class Crew{
    var name: String?
    var character: String?
    var imagePath: String?
    
    init(name: String? = nil, character: String? = nil, imagePath: String? = nil) {
        self.name = name
        self.character = character
        self.imagePath = imagePath
    }
}
