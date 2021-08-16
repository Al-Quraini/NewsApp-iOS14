//
//  NewsManager.swift
//  NewsApp
//
//  Created by Mohammed Al-Quraini on 7/22/21.
//

import UIKit

protocol NewsManagerDelegate {
    func didDownloadNews(_ newsManager : NewsManager , articles : [Article])
    func didFailWithError(_ error : Error)
}

struct NewsManager {
    var delegate : NewsManagerDelegate?
    
    func performRequest(){
        
        //1. Create a URL
        guard let url = URL(string: K.baseUrl) else {
            fatalError()
        }
        
        //2. Create a URL session
        let session = URLSession(configuration: .default)
        
        //3. Give the session a task
        let task = session.dataTask(with: url) { data, response, error  in
            if error != nil {
                delegate?.didFailWithError(error!)
                return
            }
            
            guard let safeData = data else {
                fatalError()
            }
            
            guard let articles : [Article] = parseJson(safeData) else {
                fatalError()
            }
            
            
            delegate?.didDownloadNews(self, articles: articles)
//            print(articles)
            
        }
        
        //4. start the task
        task.resume()
    }
    
    func configureNewsCell(){
        
    }
    
    
    func parseJson(_ newsData : Data) -> [Article]?{
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode(NewsData.self, from: newsData)
            
            var articles : [Article] = []
            for article in decodeData.articles {
                articles.append(Article(title: article.title!, imageUrl: article.urlToImage,
            description: article.description ?? "no description available", articleUrl: article.url, publishedAt: article.publishedAt!))
            }
            return articles
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
