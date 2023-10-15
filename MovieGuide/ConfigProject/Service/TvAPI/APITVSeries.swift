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
        let serviceURL = ConfigURL.tvShowTopRateURL()
        let parameters: [String: Any] = [:]
        
        CenterConfigService.customFire(serviceURL, parameters: parameters) { result in
            switch result{
            case .success(let dataReturn):
                do{
                    let model = try JSONDecoder().decode(TvTopRateDataModel.self, from: dataReturn)
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
    
    //MARK: Popular
    static func getTvShowPopular(completionBlock: @escaping (TvPopularDataModel?, String?) -> Void) -> Void {
        let serviceURL = ConfigURL.tvShowPopular()
        let parameters: [String: Any] = [:]
        
        CenterConfigService.customFire(serviceURL, parameters: parameters) { result in
            switch result{
            case .success(let dataReturn):
                do{
                    let model = try JSONDecoder().decode(TvPopularDataModel.self, from: dataReturn)
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
    
    //MARK: On Air
    static func getTvShowOnAir(completionBlock: @escaping (TvPopularDataModel?, String?) -> Void) -> Void {
        let serviceURL = ConfigURL.tvShowPopular()
        let parameters: [String: Any] = [:]
        CenterConfigService.customFire(serviceURL, parameters: parameters) { result in
            switch result{
            case .success(let dataReturn):
                do{
                    let model = try JSONDecoder().decode(TvPopularDataModel.self, from: dataReturn)
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
    
    
    //MARK: Detail
    static func getTVDetail(idTV: String,completionBlock: @escaping (TvSeriesIDDetail?, String?) -> Void) -> Void {
        let serviceURL = ConfigURL.tvShowPopular() + idTV
        let parameters: [String: Any] = [:]
        CenterConfigService.customFire(serviceURL, parameters: parameters) { result in
            switch result{
            case .success(let dataReturn):
                do{
                    let model = try JSONDecoder().decode(TvSeriesIDDetail.self, from: dataReturn)
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
