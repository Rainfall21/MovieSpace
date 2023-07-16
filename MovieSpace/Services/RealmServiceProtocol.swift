//
//  FetchRealmViewModel.swift
//  MovieSpace
//
//  Created by Alibek Ismagulov on 15.07.2023.
//

import Foundation
import SwiftUI
import RealmSwift

protocol RealmServiceProtocol {
    func addMovie(_ movie: MovieModel) -> Void
    func readMovies() -> [MovieModel]
    func deleteMovie(_ id : String) -> Void
    func findMovie(_ movie: MovieModel) -> Bool
}
