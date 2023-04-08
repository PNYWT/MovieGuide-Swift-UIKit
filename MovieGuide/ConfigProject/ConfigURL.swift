//
//  ConfigURL.swift
//  MovieGuide
//
//  Created by Dev on 25/3/2566 BE.
//

import Foundation
let api_key = "d86faff0304420d80a4eb8624dd3a665"
let domainString = "https://api.themoviedb.org/3"
let language = "&language=en-US&page=1"

let popularPath = "/movie/popular"
let moviesIdPath = "/movie/"
let topMoviesPath = "/movie/top_rated"
let tvShowTopRatePath = "/tv/top_rated"

class ConfigURL:NSObject{
    
    static let popularMovieURL = domainString + popularPath
    static let movieIDURL = domainString + moviesIdPath
    static let topMovieURL = domainString + topMoviesPath
    static let tvShowTopRateURL = domainString + tvShowTopRatePath
    
    override init() {
        super.init()
    }
}
