//
//  MovieItemView.swift
//  MovieSpace
//
//  Created by Alibek Ismagulov on 15.07.2023.
//

import Foundation
import SwiftUI

struct MovieItem: View {
    let movie: MovieModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: movie.poster)!) { phase in
                switch phase {
                case .empty:
                    Color.blue
                case .success(let image):
                    image
                        .resizable()
                case .failure:
                    Color.red
                }
            }
            .frame(width: 50, height: 50)
            Text(movie.title)
            Spacer()
            Text(String(movie.year))
            
        }
    }
}
