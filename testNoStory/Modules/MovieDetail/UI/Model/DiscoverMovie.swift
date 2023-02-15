//
//  DiscoverMovie.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//

import Foundation
class DiscoverMovie{
    var title: String?
    var dateRelease: String?
    var duration: String?
    var genres: String?
    var budget: String?
    var revenue: String?
    var status: String?
    
    init(title: String? = nil, dateRelease: String? = nil, duration: String? = nil, genres: String? = nil, budget: String? = nil, revenue: String? = nil, status: String? = nil) {
        self.title = title
        self.dateRelease = dateRelease
        self.duration = duration
        self.genres = genres
        self.budget = budget
        self.revenue = revenue
        self.status = status
    }
    
    init(){}
}
