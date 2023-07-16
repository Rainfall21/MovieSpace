//
//  MovieModel.swift
//  MovieSpace
//
//  Created by Alibek Ismagulov on 15.07.2023.
//

import Foundation
import RealmSwift

struct MovieList : Codable {
    var movies : [MovieModel]

    enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
}

struct MovieModel : Codable, Identifiable {
    
    init(title: String, year: String, poster: String, imdbID: String) {
        self.title = title
        self.year = year
        self.runtime = nil
        self.genre = nil
        self.director = nil
        self.actors = nil
        self.plot = nil
        self.poster = poster
        self.imdbID = imdbID
    }
    
    let title : String
    let year : String
    let runtime : String?
    let genre : String?
    let director : String?
    let actors : String?
    let plot : String?
    let poster : String
    var id: String {
        imdbID
    }
    var imdbID : String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case poster = "Poster"
        case imdbID
    }
}
