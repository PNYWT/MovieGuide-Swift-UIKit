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

class ConfigURL:NSObject{

    //movie
    static func popularMovieURL()-> String{
        return String(format: "%@/movie/popular", domainString)
    }
    
    static func movieDetail()-> String{
        return String(format: "%@/movie/", domainString)
    }
    
    static func topMovieURL()->String{
        return String(format: "%@/movie/top_rated", domainString)
    }
    
    static func upcomingMovieURL()->String{
        return String(format: "%@/movie/upcoming", domainString)
    }
    
    //TV Series
    static func tvShowTopRateURL()->String{
        return String(format: "%@/tv/top_rated", domainString)
    }
    
    static func tvShowDetail()->String{
        return String(format: "%@/tv/", domainString)
    }
    
    static func tvShowPopular()->String{
        return String(format: "%@/tv/popular", domainString)
    }
    
    static func tvShowOnAir()->String{
        return String(format: "%@/tv/on_the_air", domainString)
    }
    
    override init() {
        super.init()
    }
}
