//
//  APIMovie.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import Foundation

class APIMovie: NSObject, URLSessionDataDelegate{
    
    private var dataTask: URLSessionDataTask?
    
    static func getPopularMoviesData(completionBlock: @escaping (PopularMovieDataModel?, String?) -> Void) -> Void {
        let popularMovieURL = ConfigURL.popularMovie()
        
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
            print("URL ->\(url)\nResponse status code -> \(response.statusCode)")
            
            guard let dataSucc = data else{
                print("Data -> Empty")
                return
            }
            APIMovie.logResponse(data: data)
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PopularMovieDataModel.self, from: dataSucc)
                DispatchQueue.main.async {
                    completionBlock(jsonData, nil)
                }
            }catch let error{
                completionBlock(nil, error.localizedDescription)
            }
        }.resume()
    }
    
    static func getMovieIDData(idMovie: String,completionBlock: @escaping (MovieIDDataModel?, String?) -> Void) -> Void {
        let movieIDURL = ConfigURL.movieID(id: idMovie)
        print("movieIDURL -> \(movieIDURL)")
        
        guard let url = URL(string: movieIDURL) else {return}
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
            print("URL ->\(url)\nResponse status code -> \(response.statusCode)")
            
            guard let dataSucc = data else{
                print("Data -> Empty")
                return
            }
            APIMovie.logResponse(data: data)
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieIDDataModel.self, from: dataSucc)
                DispatchQueue.main.async {
                    completionBlock(jsonData, nil)
                }
            }catch let error{
                completionBlock(nil, error.localizedDescription)
            }
        }.resume()
    }

    static func logResponse(data:Data?){
        if let dataSucc = data{
            do{
                let jsonObject = try JSONSerialization.jsonObject(with: dataSucc, options: [])
                let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                let prettyJsonString = String(data: prettyJsonData, encoding: .utf8) ?? ""
                print(prettyJsonString)
            }catch let error{
                print("logResponse ->  \(error.localizedDescription)")
            }
        }
    }
}
