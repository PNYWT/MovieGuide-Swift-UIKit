//
//  TvShowModel.swift
//  MovieGuide
//
//  Created by Dev on 28/3/2566 BE.
//

import Foundation

//MARK: TopRate
struct TvTopRateDataModel: Decodable{
    let tvTopRateModel : [TvTopRateModel]
    
    private enum CodingKeys: String, CodingKey{
        case tvTopRateModel = "results"
    }
}

struct TvTopRateModel: Decodable{
    let idTV:Int?
    let titleName:String?
    let year:String?
    let rateing:Double?
    let posterImageURL:String?
    let overview:String?
    let onAir:String?
    
    private enum CodingKeys: String, CodingKey{
        case idTV = "id"
        case titleName = "original_name"
        case overview
        case year = "release_date"
        case rateing = "vote_average"
        case posterImageURL = "poster_path"
        case onAir = "first_air_date"
    }
}
