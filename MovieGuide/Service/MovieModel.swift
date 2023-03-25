//
//  MovieModel.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import Foundation


struct MovieDataModel: Decodable{
    let moviesModel : [MovieModel]
    
    private enum CodingKeys: String, CodingKey{
        case moviesModel = "results"
    }
}

struct MovieModel: Decodable{
    let title:String?
    let year:String?
    let rateing:Double?
    let posterImageURL:String?
    let overview:String?
    
    private enum CodingKeys: String, CodingKey{
        case title, overview
        case year = "release_date"
        case rateing = "vote_average"
        case posterImageURL = "poster_path"
    }
}
