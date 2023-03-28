//
//  APIMovie.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import Foundation

enum APIStatus {
    case REQUEST
    case RESPONSE
}

class APIMovie: NSObject, URLSessionDataDelegate{
    
    private var dataTask: URLSessionDataTask?
    
    static func getPopularMoviesData(completionBlock: @escaping (PopularMovieDataModel?, String?) -> Void) -> Void {
        let popularMovieURL = ConfigURL.popularMovieURL
        var components = URLComponents(string: popularMovieURL)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: api_key),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        guard let url = components.url else {return}
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
            
            guard let dataSucc = data else{
                print("Data -> Empty")
                return
            }
            logResponse(url: popularMovieURL, status: response.statusCode, data: data, _type: .REQUEST)
           
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PopularMovieDataModel.self, from: dataSucc)
                DispatchQueue.main.async {
                    logResponse(url: "\(url)", status: response.statusCode, data: data, _type: .RESPONSE)
                    completionBlock(jsonData, nil)
                }
            }catch let error{
                completionBlock(nil, error.localizedDescription)
            }
        }.resume()
    }
    
    
    static func getMovieIDData(idMovie: String,completionBlock: @escaping (MovieIDDataModel?, String?) -> Void) -> Void {
        let movieIDURL = ConfigURL.movieIDURL + idMovie
        guard var components = URLComponents(string: movieIDURL) else { return }
        components.queryItems = [URLQueryItem(name: "api_key", value: api_key)]
        
        guard let url = components.url else { return }
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
            
            guard let dataSucc = data else{
                print("Data -> Empty")
                return
            }
            logResponse(url: movieIDURL, status: response.statusCode, data: data, _type: .REQUEST)
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieIDDataModel.self, from: dataSucc)
                DispatchQueue.main.async {
                    logResponse(url: "\(url)", status: response.statusCode, data: data, _type: .RESPONSE)
                    completionBlock(jsonData, nil)
                }
            }catch let error{
                completionBlock(nil, error.localizedDescription)
            }
        }.resume()
    }
    
    static func getTopMovieData(completionBlock: @escaping (TopMovieDataModel?, String?) -> Void) -> Void {
        let topMovie = ConfigURL.topMovieURL
        var components = URLComponents(string: topMovie)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: api_key),
        ]
        
        guard let url = components.url else {return}
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
            
            guard let dataSucc = data else{
                print("Data -> Empty")
                return
            }
            logResponse(url: topMovie, status: response.statusCode, data: data, _type: .REQUEST)
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TopMovieDataModel.self, from: dataSucc)
                DispatchQueue.main.async {
                    logResponse(url: "\(url)", status: response.statusCode, data: data, _type: .RESPONSE)
                    completionBlock(jsonData, nil)
                }
            }catch let error{
                completionBlock(nil, error.localizedDescription)
            }
        }.resume()
    }

    static func getTvShowTopRate(completionBlock: @escaping (TvTopRateDataModel?, String?) -> Void) -> Void {
        let tvShowTopRateURL = ConfigURL.tvShowTopRateURL
        var components = URLComponents(string: tvShowTopRateURL)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: api_key),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        guard let url = components.url else {return}
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
            
            guard let dataSucc = data else{
                print("Data -> Empty")
                return
            }
            logResponse(url: tvShowTopRateURL, status: response.statusCode, data: data, _type: .REQUEST)
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvTopRateDataModel.self, from: dataSucc)
                DispatchQueue.main.async {
                    logResponse(url: "\(url)", status: response.statusCode, data: data, _type: .RESPONSE)
                    completionBlock(jsonData, nil)
                }
            }catch let error{
                completionBlock(nil, error.localizedDescription)
            }
        }.resume()
    }
}
