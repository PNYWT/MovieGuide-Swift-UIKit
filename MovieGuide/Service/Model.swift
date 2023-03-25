//
//  MovieModel.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import Foundation


//Poplular
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


//MovieID
struct MovieIDDataModel: Decodable{
    let tagline:String?
    let title:String?
    let overview:String?
    let imdb_id:String?
    let genres:[GenresMovieId]
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

struct GenresMovieId: Decodable{
    let id:Int?
    let name:String?
    
    private enum CodingKeys: String, CodingKey{
        case id, name
    }
}
