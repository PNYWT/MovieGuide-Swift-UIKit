//
//  APITV.swift
//  MovieGuide
//
//  Created by Dev on 28/3/2566 BE.
//

import Foundation


class APITVSeries: NSObject, URLSessionDataDelegate{
    
    private var dataTask: URLSessionDataTask?

    //MARK: Top Rate
    static func getTvShowTopRate(completionBlock: @escaping (TvTopRateDataModel?, String?) -> Void) -> Void {
        let tvShowTopRateURL = ConfigURL.tvShowTopRateURL()
        guard var components = URLComponents(string: tvShowTopRateURL) else{
            return
        }
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
    
    //MARK: Popular
    static func getTvShowPopular(completionBlock: @escaping (TvPopularDataModel?, String?) -> Void) -> Void {
        let tvShowTopPopular = ConfigURL.tvShowPopular()
        guard var components = URLComponents(string: tvShowTopPopular) else{
            return
        }
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
            logResponse(url: tvShowTopPopular, status: response.statusCode, data: data, _type: .REQUEST)
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvPopularDataModel.self, from: dataSucc)
                DispatchQueue.main.async {
                    logResponse(url: "\(url)", status: response.statusCode, data: data, _type: .RESPONSE)
                    completionBlock(jsonData, nil)
                }
            }catch let error{
                completionBlock(nil, error.localizedDescription)
            }
        }.resume()
    }
    
    //MARK: On Air
    static func getTvShowOnAir(completionBlock: @escaping (TvPopularDataModel?, String?) -> Void) -> Void {
        let tvShowTopPopular = ConfigURL.tvShowPopular()
        guard var components = URLComponents(string: tvShowTopPopular) else{
            return
        }
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
            logResponse(url: tvShowTopPopular, status: response.statusCode, data: data, _type: .REQUEST)
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvPopularDataModel.self, from: dataSucc)
                DispatchQueue.main.async {
                    logResponse(url: "\(url)", status: response.statusCode, data: data, _type: .RESPONSE)
                    completionBlock(jsonData, nil)
                }
            }catch let error{
                completionBlock(nil, error.localizedDescription)
            }
        }.resume()
    }
    
    
    //MARK: Detail
    static func getTVDetail(idTV: String,completionBlock: @escaping (TvSeriesIDDetail?, String?) -> Void) -> Void {
        let tvDetailRL = ConfigURL.tvShowDetail() + idTV
        guard var components = URLComponents(string: tvDetailRL) else { return }
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
            logResponse(url: tvDetailRL, status: response.statusCode, data: data, _type: .REQUEST)
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvSeriesIDDetail.self, from: dataSucc)
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
