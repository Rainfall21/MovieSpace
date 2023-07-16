//
//  FetchMoviesViewModel.swift
//  MovieSpace
//
//  Created by Alibek Ismagulov on 15.07.2023.
//

import Foundation
import SwiftUI

class FetchMoviesViewModel : ObservableObject {
    let url = "https://www.omdbapi.com/?apikey=6a30d911"
    
    func fetchMovies(_ searchText : String, completion: @escaping (Result<[MovieModel],Error>) -> Void) {
        var urlString : String = ""
        if searchText.count > 3 {
            let text = modifySearchText(text: searchText)
            urlString = "\(url)&s=\(text)"
        } else {
            let text = modifySearchText(text: searchText)
            urlString = "\(url)&t=\(text)"
        }
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let data {
                    let decoder = JSONDecoder()
                    do {
                        let movieModel = try decoder.decode(MovieList.self, from: data).movies
                        completion(.success(movieModel))
                    }catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
    
    func fetchMovieDetails(_ movieID : String, completion: @escaping (MovieModel) -> Void) {
        let urlString = "\(url)&i=\(movieID)"
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let data {
                    let decoder = JSONDecoder()
                    do {
                        let movieModel = try decoder.decode(MovieModel.self, from: data)
                        completion(movieModel)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
    
    func modifySearchText(text: String) -> String {
        let pattern = "\\s+$"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(text.startIndex..., in: text)
        let trimmed = regex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "")
        let searchText = trimmed.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        
        return searchText
    }
}
