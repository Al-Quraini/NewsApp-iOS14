//
//  ArticleWebViewViewController.swift
//  NewsApp
//
//  Created by Mohammed Al-Quraini on 7/24/21.
//

import UIKit
import WebKit

protocol ArticleLikeDelegate   {
    func didLikeArticle(_ articleWebViewController : ArticleWebViewViewController, article : Article)
}

class ArticleWebViewViewController: UIViewController {
    
    var delegate : ArticleLikeDelegate?
    
    let webView = WKWebView()
    
    let button : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.imageView?.tintColor = .white
//        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var article : Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if   article?.isLiked == false {
            button.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            button.tintColor = .yellow
        }
        else {
            button.backgroundColor = UIColor.systemYellow
            button.tintColor = .white
        }
        
        // Do any additional setup after loading the view.
        view.addSubview(webView)
        view.addSubview(button)
        
        
        webViewConstraints()
        buttonConstraints()
        
        
        self.webView.load(URLRequest(url: URL(string: self.article!.articleUrl)!))
        
        button.addTarget(self, action: #selector(likeArticle(_:)), for: .touchUpInside)

        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        webView.frame = view.bounds
    }
    
    @objc private func likeArticle(_ sender : UIButton){
        self.article?.isLiked.toggle()
        
        delegate?.didLikeArticle(self, article: article!)
        
        if article?.isLiked == true {
            button.backgroundColor = .systemYellow
            button.tintColor = .yellow
        }
        else {
            button.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            button.tintColor = .yellow
        }
        
        
        
    }
    
    func webViewConstraints(){
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func buttonConstraints(){
        
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        button.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }

}
