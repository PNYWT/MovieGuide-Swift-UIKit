//
//  CustomService.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import Foundation
import Alamofire

class CustomService{
    static func getTrendingMovies(completion: @escaping (Result<[HomeMovieDetail], Error>) -> Void) {
        let url = "\(ConfigURL.mainBaseURL)/3/trending/movie/day?api_key=\(ConfigURL.getKeybyName(forKey: ConfigURL.API_KEY))"
        
        AF.request(url).responseDecodable(of: TrendingTitleModel.self) { response in
            switch response.result {
            case .success(let trendingTitleModel):
                completion(.success(trendingTitleModel.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getUpcomingMovies(completion: @escaping (Result<[HomeMovieDetail], Error>) -> Void) {
        let url = "\(ConfigURL.mainBaseURL)/3/movie/upcoming?api_key=\(ConfigURL.getKeybyName(forKey: ConfigURL.API_KEY))&language=en-US&page=1"
        
        AF.request(url).responseDecodable(of: TrendingTitleModel.self) { response in
            switch response.result {
            case .success(let trendingTitleModel):
                completion(.success(trendingTitleModel.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getPopular(completion: @escaping (Result<[HomeMovieDetail], Error>) -> Void) {
        let url = "\(ConfigURL.mainBaseURL)/3/movie/popular?api_key=\(ConfigURL.getKeybyName(forKey: ConfigURL.API_KEY))&language=en-US&page=1"
        
        AF.request(url).responseDecodable(of: TrendingTitleModel.self) { response in
            switch response.result {
            case .success(let trendingTitleModel):
                completion(.success(trendingTitleModel.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getTopRated(completion: @escaping (Result<[HomeMovieDetail], Error>) -> Void) {
        let url = "\(ConfigURL.mainBaseURL)/3/movie/top_rated?api_key=\(ConfigURL.getKeybyName(forKey: ConfigURL.API_KEY))&language=en-US&page=1"
        
        AF.request(url).responseDecodable(of: TrendingTitleModel.self) { response in
            switch response.result {
            case .success(let trendingTitleModel):
                completion(.success(trendingTitleModel.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getTrendingTv(completion: @escaping (Result<[HomeMovieDetail], Error>) -> Void) {
        let url = "\(ConfigURL.mainBaseURL)/3/trending/tv/day?api_key=\(ConfigURL.getKeybyName(forKey: ConfigURL.API_KEY))"
        
        AF.request(url).responseDecodable(of: TrendingTitleModel.self) { response in
            switch response.result {
            case .success(let trendingTitleModel):
                completion(.success(trendingTitleModel.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getDiscoveryMovies(completion: @escaping (Result<[HomeMovieDetail], Error>) -> Void) {
        let url = "\(ConfigURL.mainBaseURL)/3/discover/movie?api_key=\(ConfigURL.getKeybyName(forKey: ConfigURL.API_KEY))&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        
        AF.request(url).responseDecodable(of: TrendingTitleModel.self) { response in
            switch response.result {
            case .success(let trendingTitleModel):
                completion(.success(trendingTitleModel.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func search(with query: String, completion: @escaping (Result<[HomeMovieDetail], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        let url = "\(ConfigURL.mainBaseURL)/3/search/movie?api_key=\(ConfigURL.getKeybyName(forKey: ConfigURL.API_KEY))&query=\(query)"
        
        AF.request(url).responseDecodable(of: TrendingTitleModel.self) { response in
            switch response.result {
            case .success(let results):
                completion(.success(results.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        let url = "\(ConfigURL.youtubeBaseURL)q=\(query)&key=\(ConfigURL.getKeybyName(forKey: ConfigURL.youtubeBaseURL))"
        
        AF.request(url).responseDecodable(of: YoutubeSearchModel.self) { response in
            switch response.result {
            case .success(let youtubeSearchModel):
                completion(.success(youtubeSearchModel.items[0]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
