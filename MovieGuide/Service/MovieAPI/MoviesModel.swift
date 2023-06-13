//
//  MovieModel.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import Foundation


//MARK: Poplular
struct PopularMovieDataModel: Decodable{
    let moviesModel : [PopularMovieModel]
    
    private enum CodingKeys: String, CodingKey{
        case moviesModel = "results"
    }
}

struct PopularMovieModel: Decodable{
    let idMovie:Int?
    let title:String?
    let year:String?
    let rateing:Double?
    let posterImageURL:String?
    let overview:String?
    
    private enum CodingKeys: String, CodingKey{
        case idMovie = "id"
        case title, overview
        case year = "release_date"
        case rateing = "vote_average"
        case posterImageURL = "poster_path"
    }
}


//MARK: MovieID
struct MovieIDDetail: Decodable{
    let tagline:String?
    let title:String?
    let overview:String?
    let imdb_id:String?
    let genres:[GenresMovie]
    let release_date:String?
    let budget:Int?
    let runtime:Int?
    let posterImageURL:String?
    
    private enum CodingKeys: String, CodingKey{
        case title, overview, tagline, imdb_id, release_date, budget, runtime
        case genres = "genres"
        case posterImageURL = "poster_path"
    }
}

struct GenresMovie: Decodable{
    let id:Int?
    let name:String?
    
    private enum CodingKeys: String, CodingKey{
        case id, name
    }
}

//MARK: TopMovie
struct TopMovieDataModel: Decodable{
    let topMovieModel : [TopMovieModel]
    
    private enum CodingKeys: String, CodingKey{
        case topMovieModel = "results"
    }
}

struct TopMovieModel: Decodable{
    let idMovie:Int?
    let title:String?
    let year:String?
    let rateing:Double?
    let posterImageURL:String?
    let overview:String?
    
    private enum CodingKeys: String, CodingKey{
        case idMovie = "id"
        case title, overview
        case year = "release_date"
        case rateing = "vote_average"
        case posterImageURL = "poster_path"
    }
}

//MARK: UpComing
struct UpComingDataModel: Decodable{
    let upComingModel : [UpComingModel]
    let page:Int?
    
    private enum CodingKeys: String, CodingKey{
        case upComingModel = "results"
        case page
    }
}

struct UpComingModel: Decodable{
    let idTopMovie:Int?
    let posterImageURL:String?
    let voteScore:Double?
    
    private enum CodingKeys: String, CodingKey{
        case idTopMovie = "id"
        case posterImageURL = "backdrop_path"
        case voteScore = "vote_average"
    }
}
