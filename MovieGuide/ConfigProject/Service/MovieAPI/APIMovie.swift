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
        
        AF.request(serviceURL, method: .get, parameters: CenterConfigService.defualtParameter(param: parameters))
            .responseDecodable(of: PopularMovieDataModel.self) { response in
                switch response.result {
                case .success(let model):
                    // รีเควสสำเร็จและข้อมูลถูกแปลงเป็นโมเดล YourModel
                    DispatchQueue.main.async {
                        logResponse(url: serviceURL, status: response.response?.statusCode ?? 1002, data: response.data, _type: .RESPONSE)
                        completionBlock(model, nil)
                    }
                case .failure(let error):
                    // รีเควสไม่สำเร็จ
                    completionBlock(nil, "Error: \(error)")
                }
            }
    }
    
    static func getMovieDetail1(idMovie: String,completionBlock: @escaping (MovieIDDetail?, String?) -> Void) -> Void {
        let serviceURL = ConfigURL.movieDetail() + idMovie
        let parameters: [String: Any] = [:]
        
        AF.request(serviceURL, method: .get, parameters: CenterConfigService.defualtParameter(param: parameters))
            .responseDecodable(of: MovieIDDetail.self) { response in
                switch response.result {
                case .success(let model):
                    // รีเควสสำเร็จและข้อมูลถูกแปลงเป็นโมเดล YourModel
                    DispatchQueue.main.async {
                        logResponse(url: serviceURL, status: response.response?.statusCode ?? 1002, data: response.data, _type: .RESPONSE)
                        completionBlock(model, nil)
                    }
                case .failure(let error):
                    // รีเควสไม่สำเร็จ
                    completionBlock(nil, "Error: \(error)")
                }
            }
    }
    
    //MARK: Select to red detail movie
    static func getMovieDetail(idMovie: String,completionBlock: @escaping (MovieIDDetail?, String?) -> Void) -> Void {
        let movieIDURL = ConfigURL.movieDetail() + idMovie
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
                let jsonData = try decoder.decode(MovieIDDetail.self, from: dataSucc)
                DispatchQueue.main.async {
                    logResponse(url: "\(url)", status: response.statusCode, data: data, _type: .RESPONSE)
                    completionBlock(jsonData, nil)
                }
            }catch let error{
                completionBlock(nil, error.localizedDescription)
            }
        }.resume()
    }
    
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
