//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Mohammed Al-Quraini on 7/24/21.
//

import UIKit

struct Article : Identifiable {
    var id = UUID()
    let title : String
    let imageUrl : String?
    let description : String
    let articleUrl : String
    let publishedAt : String
    var isLiked : Bool = false
}

var likedArticles : [Article] = []
