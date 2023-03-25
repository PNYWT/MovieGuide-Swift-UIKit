//
//  APIMovie.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import Foundation

class APIMovie{
    let api_key = "d86faff0304420d80a4eb8624dd3a665"
    
    private var dataTask: URLSessionDataTask?
    
    func getPopularMoviesData(completionBlock: @escaping (MovieDataModel?, String?) -> Void) -> Void {
        let popularMovieURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(api_key)&language=en-US&page=1"

        guard let url = URL(string: popularMovieURL) else {return}

        URLSession.shared.dataTask(with: url) { data, res, err in
            if let error = err{
                completionBlock(nil, error.localizedDescription)
                print("URLSession Error -> \(error.localizedDescription)")
                return
            }

            guard let response = res as? HTTPURLResponse else{
                print("HTTPURLResponse Response -> Empty")
                return
            }
            print("Response status code -> \(response.statusCode)")

            guard let dataSucc = data else{
                print("Data -> Empty")
                return
            }

            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieDataModel.self, from: dataSucc)

                DispatchQueue.main.async {
                    completionBlock(jsonData, nil)
                }
            }catch let error{
                completionBlock(nil, error.localizedDescription)
            }
        }.resume()
    }
}

/*
 apiService.getPopularMoviesData { (result) in
 print(result)
 }
func getPopularMoviesData(completion: @escaping (Result<MovieDataModel, Error>) ->Void){
    let popularMovieURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(api_key)&language=en-US&page=1"

    guard let url = URL(string: popularMovieURL) else {return}

    URLSession.shared.dataTask(with: url) { data, res, err in
        if let error = err{
            completion(.failure(error))
            print("URLSession Error -> \(error.localizedDescription)")
            return
        }

        guard let response = res as? HTTPURLResponse else{
            print("HTTPURLResponse Response -> Empty")
            return
        }
        print("Response status code -> \(response.statusCode)")

        guard let dataSucc = data else{
            print("Data -> Empty")
            return
        }

        do {
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(MovieDataModel.self, from: dataSucc)

            DispatchQueue.main.async {
                completion(.success(jsonData))
            }
        }catch let error{
            completion(.failure(error))
        }
    }.resume()
}
 */
