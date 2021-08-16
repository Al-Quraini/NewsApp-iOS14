//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Mohammed Al-Quraini on 7/22/21.
//

import UIKit

class ArticleCell: UITableViewCell {

    var article : Article?

    var articleImageView = UIImageView()
    var favouriteImageView = UIImageView()

    var articleTitleLabel = UILabel()
    var articleDescriptionLabel = UILabel()
    var articleDateLabel = UILabel()

    private var task: URLSessionDataTask?
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(articleImageView)
        addSubview(articleTitleLabel)
        addSubview(articleDescriptionLabel)
        addSubview(articleDateLabel)
        addSubview(favouriteImageView)
        
        configureImageView()
        configureTitleLabel()
        configureDescriptionLabel()
        configureDateLabel()
        configureFavouriteImageView()
        
        
        setImageConstraints()
        setLableConstraints()
        setDescriptionConstraints()
        setFavouriteImageConstraints()
        setDateConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureImageView(){
        articleImageView.layer.cornerRadius = 10
        articleImageView.clipsToBounds = true
        articleImageView.contentMode = .scaleAspectFill
        
    }
    
    func configureFavouriteImageView(){
        favouriteImageView.layer.cornerRadius = 10
        favouriteImageView.tintColor = .systemYellow
        favouriteImageView.clipsToBounds = true
        favouriteImageView.image = UIImage(systemName: "star")
        favouriteImageView.contentMode = .scaleAspectFill
        
    }
    
    func configureTitleLabel(){
        articleTitleLabel.numberOfLines = 3
        articleTitleLabel.adjustsFontSizeToFitWidth = false
        articleTitleLabel.text = "This is our intro to the new world"
        articleTitleLabel.font = articleTitleLabel.font.withSize(14)
    }
    
    func configureDescriptionLabel(){
        articleDescriptionLabel.numberOfLines = 3
        articleDescriptionLabel.adjustsFontSizeToFitWidth = false
        articleDescriptionLabel.text = "This is the description"
        articleDescriptionLabel.font = articleTitleLabel.font.withSize(10)
        
        
    }
    
    func configureDateLabel(){
        articleDateLabel.numberOfLines = 1
        articleDateLabel.adjustsFontSizeToFitWidth = false
        articleDateLabel.text = "This is our intro to the new world"
        articleDateLabel.font = articleTitleLabel.font.withSize(8)
        
    }
    
    func configureArticle(article : Article){
        self.article = article
        loadData()
    }
    
    
    func loadData(){
        cacheImage()
        articleTitleLabel.text = article?.title
        articleDescriptionLabel.text = article?.description
        articleDateLabel.text = article?.publishedAt
        favouriteImageView.image = UIImage(systemName: article!.isLiked ? "star.fill" : "star")
        
    }

    func setImageConstraints(){
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
//        articleImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        articleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        articleImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        articleImageView.widthAnchor.constraint(equalTo: articleImageView.heightAnchor, multiplier: 4/3).isActive = true
    }
    
    func setFavouriteImageConstraints(){
        favouriteImageView.translatesAutoresizingMaskIntoConstraints = false
//        articleImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        favouriteImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
//        articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        favouriteImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        favouriteImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        favouriteImageView.widthAnchor.constraint(equalTo: favouriteImageView.heightAnchor).isActive = true
    }
    
    func setLableConstraints(){
        articleTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        articleTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        articleTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        articleTitleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 20).isActive = true
//        articleTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        articleTitleLabel.trailingAnchor.constraint(equalTo: favouriteImageView.leadingAnchor, constant: -10).isActive = true
    }
    
    func setDescriptionConstraints(){
        articleDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        articleTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        articleDescriptionLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 8).isActive = true
        articleDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
//        articleTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        articleDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
    }
    
    func setDateConstraints(){
        articleDateLabel.translatesAutoresizingMaskIntoConstraints = false
//        articleTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        articleDescriptionLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 8).isActive = true
//        articleDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
//        articleTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        articleDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        articleDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    
    func cacheImage() {
        let url = URL(string: article!.imageUrl ?? "https://image.shutterstock.com/image-vector/ui-image-placeholder-wireframes-apps-260nw-1037719204.jpg")
        
        
        task = URLSession.shared.dataTask(with: url!) { [weak self] (data, _, _) in
                if let data = data {
                    // Create Image and Update Image View
                    DispatchQueue.main.async {
                        self?.articleImageView.image = UIImage(data: data)

                    }
                }
            }

            // Start Data Task
            task!.resume()
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        articleImageView.image = nil
    }
    
    
}

