//
//  FavouritesViewController.swift
//  NewsApp
//
//  Created by Mohammed Al-Quraini on 7/24/21.
//

import UIKit


class FavouritesViewController: UIViewController {
    
    static let navigationTitle : String = "Favourite"
    
    var favouriteArticles : [Article] = []
    
    let tableView = UITableView()
    let centeredLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        label.text = "No liked items..."
//        label.font = label.font.withSize(20)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouriteArticles = likedArticles

        initView()
        addObserver()
        
    }
    
    func initView() {
        if favouriteArticles.count > 0 {
            if !view.subviews.isEmpty {
                centeredLabel.removeFromSuperview()
            }
            
            view.addSubview(tableView)
            
            setTableViewDelegate()
            
            tableViewConfigureation()
            
            tableViewConstraints()
            
            
            
        }
        
        else {
            if !view.subviews.isEmpty {
                tableView.removeFromSuperview()
            }
            centeredLabel.center = view.center
            view.addSubview(centeredLabel)
        }
    }
    
    
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabel), name: NSNotification.Name(rawValue: "name"), object: nil)
    }
    
    @objc func updateLabel(_ notification : Notification){
        favouriteArticles = likedArticles
        initView()
        tableView.reloadData()
        
    }
    
    func setTableViewDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
        
        
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
    
    
    

    

}

//MARK: - UITableViewDelegate and UITableViewDataSource
extension FavouritesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
        
        cell.configureArticle(article: favouriteArticles[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.favouriteArticles.remove(at: indexPath.row)
            likedArticles = self.favouriteArticles
            tableView.reloadData()
            self.initView()
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [ delete])
            swipeActionConfig.performsFirstActionWithFullSwipe = false
            return swipeActionConfig
    }
    
    
    
    
    
}
