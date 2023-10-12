//
//  TvShowModel.swift
//  MovieGuide
//
//  Created by Dev on 28/3/2566 BE.
//

import Foundation

//MARK: Detail TV
struct TvSeriesIDDetail: Decodable{
    let title:String?
    let overview:String?
    let posterImageURL:String?
    let first_air_date:String?
    let number_of_episodes:Int?
    let number_of_seasons:Int?
    let last_air_date:String?
    let status:String?
    let genres:[GenresTV]
    
    
    private enum CodingKeys: String, CodingKey{
        case title = "original_name"
        case overview = "overview"
        case posterImageURL = "poster_path"
        case first_air_date
        case number_of_episodes
        case number_of_seasons
        case last_air_date
        case status
        case genres
    }
}

struct GenresTV: Decodable{
    let id:Int?
    let name:String?
    
    private enum CodingKeys: String, CodingKey{
        case id, name
    }
}

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

//MARK: TopRate
struct TvPopularDataModel: Decodable{
    let tvPopularModel : [TvPopularModel]
    
    private enum CodingKeys: String, CodingKey{
        case tvPopularModel = "results"
    }
}

struct TvPopularModel: Decodable{
    let id:Int?
    let poster_path:String?

    
    private enum CodingKeys: String, CodingKey{
        case id
        case poster_path = "poster_path"
    }
}

//MARK: OnAir
struct TvOnAirDataModel: Decodable{
    let onAirRateModel : [TvOnAirModel]
    
    private enum CodingKeys: String, CodingKey{
        case onAirRateModel = "results"
    }
}

struct TvOnAirModel: Decodable{
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
