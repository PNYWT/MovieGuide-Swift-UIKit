//
//  HomeModel.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import Foundation

struct TrendingTitleModel: Codable {
    let results: [HomeMovieDetail]
}

struct HomeMovieDetail: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

struct YoutubeSearchModel: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
