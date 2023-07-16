//
//  MoviesToWatch.swift
//  MovieSpace
//
//  Created by Alibek Ismagulov on 11.07.2023.
//

import Foundation
import RealmSwift

class MovieToWatch : Object, ObjectKeyIdentifiable {
    @Persisted var title = ""
    @Persisted var poster = ""
    @Persisted var year = ""
    @Persisted var id = ""
    
    convenience init(title: String = "", poster: String = "", year: String = "", id: String = "") {
        self.init()
        self.title = title
        self.poster = poster
        self.year = year
        self.id = id
    }
}
