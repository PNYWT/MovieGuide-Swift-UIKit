//
//  APIMovie.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import Foundation

import Alamofire

enum APIStatus {
    case REQUEST
    case RESPONSE
}

class APIMovie: NSObject, URLSessionDataDelegate{
    
    private var dataTask: URLSessionDataTask?
    
    //MARK: Movie Popular
    static func getPopularMoviesData(completionBlock: @escaping (PopularMovieDataModel?, String?) -> Void) -> Void {
        let serviceURL = ConfigURL.popularMovieURL()
        let parameters: [String: Any] = [:]
        
        
        CenterConfigService.customFire(serviceURL, parameters: parameters) { result in
            switch result{
            case .success(let dataReturn):
                print("dataReturn -> \(dataReturn)")
                do{
//                    let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                    let model = try JSONDecoder().decode(PopularMovieDataModel.self, from: dataReturn)
                    print("model -> \(model)")
                    completionBlock(model, nil)
                }catch let error{
                    completionBlock(nil, "Error: \(error)")
                }
                break
            case .failure(let error):
                completionBlock(nil, "Error: \(error)")
            }
        }
    }
    
    //MARK: Select to red detail movie
    static func getMovieDetail(idMovie: String,completionBlock: @escaping (MovieIDDetail?, String?) -> Void) -> Void {
        let serviceURL = ConfigURL.movieDetail()
        let parameters: [String: Any] = ["movie_id":idMovie]
        
        let headers: HTTPHeaders = [
                "Accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkODZmYWZmMDMwNDQyMGQ4MGE0ZWI8NjI0ZGQzYTY2NSIsInN1YiI6IjY0MWRjM2Q5ZTBlYzUxMDBiODVhZjJkZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pyI0Mu8G4G4HWHDDP6mzp5ABYLsUTuFLOhqtJx8NNs0"
            ]
        
        
//        logResponse(url: serviceURL, status: 0, data: nil, _type: .REQUEST)
//        AF.request(serviceURL, method: .get, parameters: CenterConfigService.defualtParameter(param: parameters),headers: headers)
//            .responseDecodable(of: MovieIDDetail.self) { response in
//                switch response.result {
//                case .success(let model):
//                    // รีเควสสำเร็จและข้อมูลถูกแปลงเป็นโมเดล YourModel
//                    DispatchQueue.main.async {
//                        logResponse(url: serviceURL, status: response.response?.statusCode ?? 1002, data: response.data, _type: .RESPONSE)
//                        completionBlock(model, nil)
//                    }
//                case .failure(let error):
//                    // รีเควสไม่สำเร็จ
//                    completionBlock(nil, "Error: \(error)")
//                }
//            }
    }
    
//    static func getMovieDetail(idMovie: String,completionBlock: @escaping (MovieIDDetail?, String?) -> Void) -> Void {
//        let movieIDURL = ConfigURL.movieDetail() + idMovie
//        guard var components = URLComponents(string: movieIDURL) else { return }
//        components.queryItems = [URLQueryItem(name: "api_key", value: api_key)]
//
//        guard let url = components.url else { return }
//        URLSession.shared.dataTask(with: url) { data, res, err in
//
//            if let error = err{
//                completionBlock(nil, error.localizedDescription)
//                print("URLSession Error -> \(error.localizedDescription)")
//                return
//            }
//
//            guard let response = res as? HTTPURLResponse else{
//                print("HTTPURLResponse Response -> Empty")
//                return
//            }
//
//            guard let dataSucc = data else{
//                print("Data -> Empty")
//                return
//            }
//            logResponse(url: movieIDURL, status: response.statusCode, data: data, _type: .REQUEST)
//
//            do {
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode(MovieIDDetail.self, from: dataSucc)
//                DispatchQueue.main.async {
//                    logResponse(url: "\(url)", status: response.statusCode, data: data, _type: .RESPONSE)
//                    completionBlock(jsonData, nil)
//                }
//            }catch let error{
//                completionBlock(nil, error.localizedDescription)
//            }
//        }.resume()
//    }
    
    //MARK: Top Rate
    static func getTopMovieData(completionBlock: @escaping (TopMovieDataModel?, String?) -> Void) -> Void {
        let topMovie = ConfigURL.topMovieURL
        guard var components = URLComponents(string: topMovie()) else{
            return
        }
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
            logResponse(url: topMovie(), status: response.statusCode, data: data, _type: .REQUEST)
            
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
    
    //MARK: Movie upcoming
    static func getUpcomingMovieData(completionBlock: @escaping (UpComingDataModel?, String?) -> Void) -> Void {
        let upcomingMovie = ConfigURL.upcomingMovieURL()
        guard var components = URLComponents(string: upcomingMovie) else{
            return
        }
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
            logResponse(url: upcomingMovie, status: response.statusCode, data: data, _type: .REQUEST)
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(UpComingDataModel.self, from: dataSucc)
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
