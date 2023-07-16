//
//  MovieDetailsView.swift
//  MovieSpace
//
//  Created by Alibek Ismagulov on 15.07.2023.
//

import Foundation
import SwiftUI


private extension String {
    static let movieAdded = "Movie Added"
    static let movieDeleted = "Movie Deleted"
}

struct MovieDetails: View {
    
    @State private var movieDetails : MovieModel?
    @State private var showAlert = false
    @State private var showAlertText: String = ""
    
    
    let movie: MovieModel
    let backButtonAction: () -> Void
    let realmStruct = RealmService()
    let fetchMovies = FetchMoviesViewModel()
    
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: movie.poster)!) { phase in
                    switch phase {
                    case .empty:
                        Color.blue
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Color.red
                    }
                }
                if let movieDetails = movieDetails {
                    HStack {
                        VStack {
                            Text("Release date:")
                            Text(movie.year)
                        }
                        VStack {
                            Text("Genre:")
                            Text(movieDetails.genre ?? "Not Found")
                        }
                        VStack {
                            Text("Runtime:")
                            Text(movieDetails.runtime ?? "Not Found")
                        }
                        
                    }
                    .font(.system(size: 15))
                    .padding(.bottom)
                    Text("Actors: \(movieDetails.actors ?? "Not Found")")
                        .padding(.bottom)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Directors: \(movieDetails.director ?? "Not Found")")
                        .padding(.bottom)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Plot: \(movieDetails.plot ?? "Not Found")")
                        .lineSpacing(5)
                        .padding(.bottom)
                        .padding(.leading)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .environment(\.colorScheme, .light)
        .onDisappear{
            backButtonAction()
        }
        .onAppear(perform: {
            fetchMovies.fetchMovieDetails(movie.imdbID, completion: { movieModel in
                self.movieDetails = movieModel
            })
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if realmStruct.findMovie(movie) {
                Button("Delete") {
                    realmStruct.deleteMovie(movie.imdbID)
                    showAlertText = .movieDeleted
                    showAlert = true
                }
            } else {
                Button("Add") {
                    realmStruct.addMovie(MovieModel.init(title: movie.title, year: movie.year, poster: movie.poster, imdbID: movie.imdbID))
                    showAlertText = .movieAdded
                    showAlert = true
                }

            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(showAlertText))
        }
        .navigationTitle((movie.title))
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(Color(red: 63/255, green: 114/255, blue: 175/255), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.large)
    }
    
}

