//
//  MovieSpaceView.swift
//  MovieSpace
//
//  Created by Alibek Ismagulov on 15.07.2023.
//

import Foundation
import SwiftUI


struct ContentView: View {
    
    @State private var searchText = ""
    @State private var movies: [MovieModel] = []
    @State private var errorTitle: String?
    
    let realmStruct = RealmService()
    let fetchMovies = FetchMoviesViewModel()

    
    var body: some View {
        NavigationStack {
            ZStack {
                SearchView { isSearching in
                    Color.clear
                        .onChange(of: isSearching) { newValue in
                            guard !newValue else {return}
                            errorTitle = nil
                            movies = realmStruct.readMovies()
                        }
                }
                List{
                    if errorTitle != nil {
                        Text(errorTitle!)
                    }
                    ForEach(movies) { movie in
                        NavigationLink {
                            MovieDetails(movie: movie, backButtonAction: {
                                movies = realmStruct.readMovies()
                            })
                                .background(Color.white)
                        } label: {
                            MovieItem(movie: movie)
                        }
                    }

                }
                .listStyle(GroupedListStyle())
            }
            .environment(\.colorScheme, .light)
            .navigationTitle("Movie Space")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color(red: 63/255, green: 114/255, blue: 175/255), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.large)
            
            
        }
        .onAppear(perform: {
            errorTitle = nil
            movies = realmStruct.readMovies()
        })
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Type text to search movie")
        
        .onSubmit(of: .search, {
            fetchMovies.fetchMovies(searchText) { result in
                errorTitle = nil
                switch result {
                case .success(let success):
                    self.movies = success
                case .failure(_):
                    self.errorTitle = "Could not find film. Check the spelling."
                }
            }
        })
        
    }
        
        
        struct SearchView<Content: View>: View {
            @Environment(\.isSearching) var isSearching
            let content: (Bool) -> Content
            
            var body: some View {
                content(isSearching)
            }
            
            init(@ViewBuilder content: @escaping (Bool) -> Content) {
                self.content = content
            }
        }
        
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
                    .environment(\.colorScheme, .light)
                
            }
        }
    }

