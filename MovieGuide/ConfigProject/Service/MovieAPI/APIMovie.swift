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
//                print("dataReturn -> \(dataReturn)")
                do{
                    let model = try JSONDecoder().decode(PopularMovieDataModel.self, from: dataReturn)
//                    print("model -> \(model)")
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
        let serviceURL = ConfigURL.movieDetail() + idMovie
        let parameters: [String: Any] = ["movie_id":idMovie]
        
        CenterConfigService.customFire(serviceURL, parameters: parameters) { result in
            switch result{
            case .success(let dataReturn):
//                print("dataReturn -> \(dataReturn)")
                do{
                    let model = try JSONDecoder().decode(MovieIDDetail.self, from: dataReturn)
//                    print("model -> \(model)")
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
    
    //MARK: Top Rate
    static func getTopMovieData(completionBlock: @escaping (TopMovieDataModel?, String?) -> Void) -> Void {
        let serviceURL =  ConfigURL.topMovieURL()
        let parameters: [String: Any] = [:]
        
        CenterConfigService.customFire(serviceURL, parameters: parameters) { result in
            switch result{
            case .success(let dataReturn):
//                print("dataReturn -> \(dataReturn)")
                do{
                    let model = try JSONDecoder().decode(TopMovieDataModel.self, from: dataReturn)
//                    print("model -> \(model)")
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
    
    //MARK: Movie upcoming
    static func getUpcomingMovieData(completionBlock: @escaping (UpComingDataModel?, String?) -> Void) -> Void {
        let serviceURL = ConfigURL.upcomingMovieURL()
        let parameters: [String: Any] = [:]
        
        CenterConfigService.customFire(serviceURL, parameters: parameters) { result in
            switch result{
            case .success(let dataReturn):
//                print("dataReturn -> \(dataReturn)")
                do{
                    let model = try JSONDecoder().decode(UpComingDataModel.self, from: dataReturn)
//                    print("model -> \(model)")
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
}
