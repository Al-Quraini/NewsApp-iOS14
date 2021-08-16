//
//  ViewController.swift
//  NewsApp
//
//  Created by Mohammed Al-Quraini on 7/22/21.
//

import UIKit

class NewsViewController: UIViewController {

    var tableView = UITableView()
    var newsManager = NewsManager()
    var articles : [Article]?
    var selectedArticle : Article?
//    var articeWebView = ArticleWebViewViewController()
    
    static let navigationTitle : String = "My News"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation and tabBar
    

        
        // Add Subviews
        view.addSubview(tableView)
        
        // Set Delegates
        setTableViewDelegate()
                

        
        // TableView Configuration
        tableViewConfigureation()
                
        
        // Manager
        newsManager.performRequest()
        
        
    }
    
    func setTableViewDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
        newsManager.delegate = self
//        articeWebView.delegate = self
        
        
        
    }

    
    func tableViewConfigureation(){
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.rowHeight = 150
        tableViewConstraints()
    }
    
    func tableViewConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "go" {
            let destinationVC = segue.destination as! ArticleWebViewViewController
            destinationVC.delegate = self
            destinationVC.article =   selectedArticle!
        }
    }
    


}

//MARK: - UITableViewDelegate and UITableViewDataSource extensions
extension NewsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if articles != nil {
            return articles!.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        cell.accessoryType = .disclosureIndicator
        
        if let myArticles = self.articles {
            cell.configureArticle(article: myArticles[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedArticle = articles![indexPath.row]
        
        
        performSegue(withIdentifier: "go", sender: self)
    }
    
    
}


extension NewsViewController : NewsManagerDelegate {
    func didDownloadNews(_ newsManager: NewsManager, articles: [Article]) {
        
        DispatchQueue.main.async {
            self.articles = articles
            self.tableView.reloadData()
            
        }
        
        }
    
    
    func didFailWithError(_ error: Error) {
        print(error)
    }

}


//MARK: - ArticleLikeDelegate
extension NewsViewController : ArticleLikeDelegate{
    func didLikeArticle(_ articleWebViewController: ArticleWebViewViewController, article: Article) {
        
        if let row = self.articles!.firstIndex(where: {$0.id == article.id}) {
            articles![row] = article
            
            
            if article.isLiked {
                likedArticles.append(article)
            }else {
                likedArticles.removeAll(where: {$0.id == article.id})
            }
            tableView.reloadData()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "name"), object: nil)


        }
    }
    
    
    
}

