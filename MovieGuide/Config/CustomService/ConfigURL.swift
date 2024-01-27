//
//  ConfigURL.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import Foundation

class ConfigURL{
    static let API_KEY = "API_KEY"
    static let YoutubeAPI_KEY = "YoutubeAPI_KEY"
    
    static func getKeybyName(forKey:String)->String{
        return KeyChainManager.retrieveKey(forKey: forKey) ?? ""
    }
    
    static let mainBaseURL = "https://api.themoviedb.org"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}
