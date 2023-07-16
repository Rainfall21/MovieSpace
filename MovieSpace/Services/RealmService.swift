//
//  RealmModel.swift
//  MovieSpace
//
//  Created by Alibek Ismagulov on 15.07.2023.
//

import RealmSwift
import SwiftUI

class RealmService: RealmServiceProtocol {
    
    let realm = try! Realm()
    
    func addMovie(_ movie: MovieModel) {
        let movieToWatch = MovieToWatch(title: movie.title, poster: movie.poster, year: movie.year, id: movie.imdbID)
        
        if findMovie(movie) == false {
            try! realm.write {
                realm.add(movieToWatch)
            }
        }
    }
    
    func readMovies() -> [MovieModel] {
        let moviesToWatch = realm.objects(MovieToWatch.self)
        let movies = moviesToWatch.map { moviesToWatch in
            MovieModel(title: moviesToWatch.title, year: moviesToWatch.year, poster: moviesToWatch.poster, imdbID: moviesToWatch.id)
        }
        
        return Array(movies)
    }
    
    func deleteMovie(_ id: String) {
        let movies = readMovies()
            try! realm.write {
                realm.delete(realm.objects(MovieToWatch.self).filter("id == '\(id)'"))
            }
    }
    
    func findMovie(_ movie: MovieModel) -> Bool {
        let moviesInRealm = realm.objects(MovieToWatch.self)
        let specificMovie = moviesInRealm.where {
            $0.id == "\(movie.id)"
        }
        return specificMovie.first != nil
    }
}

