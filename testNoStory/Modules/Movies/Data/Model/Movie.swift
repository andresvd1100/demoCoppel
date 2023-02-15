//
//  Movie.swift
//  testNoStory
//
//  Created by Andres Valerio on 13/02/23.
//

import Foundation

class Movie{
    let id: Int?
    let title: String?
    let releaseDate: String?
    let popularity: Double?
    let overview: String?
    let posterPath: String?
    
    init(id:Int?, title: String?, releaseDate: String?, popularity: Double?, overview: String?, posterPath: String?) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.popularity = popularity
        self.overview = overview
        self.posterPath = posterPath
    }
}
