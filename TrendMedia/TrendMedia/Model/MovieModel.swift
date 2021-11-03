//
//  MovieModel.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/26.
//

import Foundation

struct MovieModel {
    var titleData: String
    var imageData: String
    var linkData: String
    var userRateData: String
    var subTitle: String
}

struct MovieRankModel {
    var rank: Int
    var title: String
    var releasedDate: String
    var rankDate: String
}

// 배우 이름
struct Actor {
    var id: Int
    var originalName: String
    var characterName: String
    var imageLink: String
}

struct Movie {
    var id: Int
    var title: String
    var releaseDate: String
    var starring: [Actor]
    var genres: [String]
    var imageLink: String
    var backDropLink: String
    var rate: Double
    var overview: String
}
