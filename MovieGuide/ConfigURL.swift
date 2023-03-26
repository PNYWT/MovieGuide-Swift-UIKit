//
//  ConfigURL.swift
//  MovieGuide
//
//  Created by Dev on 25/3/2566 BE.
//

import Foundation
//"https://api.themoviedb.org/3/movie/popular?api_key=\(api_key)&language=en-US&page=1"
let api_key = "?api_key=d86faff0304420d80a4eb8624dd3a665"
let domainString = "https://api.themoviedb.org/3"
let language = "&language=en-US&page=1"

let popularPath = "/movie/popular"
let moviesIdPath = "/movie/"
let topMoviesPath = "/movie/top_rated"

class ConfigURL{
    static func popularMovie()->String{
        return domainString + popularPath + api_key + language
    }
    
    static func movieID(id:String)-> String{
        return domainString + moviesIdPath + id + api_key + language
    }
    
    static func topMovie()-> String{
        return domainString + topMoviesPath + api_key + language
    }
}
