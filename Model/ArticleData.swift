//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Mohammed Al-Quraini on 7/22/21.
//

import UIKit

struct NewsData : Codable {
    let articles : [ArticleData]
}

struct ArticleData : Codable {
    let source : Source
    let author : String?
    let title : String?
    let description : String?
    let url : String
    let urlToImage : String?
    let publishedAt : String?
    let content : String?
//    var liked : Bool = false
}

struct Source : Codable{
    let id : String?
    let name : String?
}
