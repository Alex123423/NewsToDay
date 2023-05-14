//
//  RecommendedCell.swift
//  NewsAPI
//
//  Created by Vitali Martsinovich on 2023-05-06.
//

import UIKit
import Kingfisher

protocol FavouriteButtonProtocol: AnyObject {
    func favouriteButtonTapped()
}

class RecommendedCell: UITableViewCell {
    
    static let identifier = "RecommendedCell"
    let bookmarksManager = BookmarksManager.shared

    weak var delegateFavoriteButton: FavouriteButtonProtocol?
    
    var liked: Bool = false
    var currentNews: Result?
    
    private let newsImageView = UIImageView()
    private let newsTitleLabel = UILabel()
    private let categoryLabel = UILabel()
    let favouriteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupView()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ newsData: Result) {
        self.newsTitleLabel.text = newsData.title
        self.categoryLabel.text = newsData.category?.first?.capitalized ?? "Without category"
        if let imageURL = newsData.imageURL, let url = URL(string: imageURL) {
            self.newsImageView.kf.setImage(with: url)
        } else {
            self.newsImageView.image = UIImage(named: "NoImage")
        }
        self.currentNews = newsData
    }
    
    func configureFavouriteButton() {
        favouriteButton.tintColor = UIColor(named: Resources.Colors.gray)
        favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        favouriteButton.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func favouriteButtonPressed() {
        if liked {
            favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            liked = false
            bookmarksManager.bookmarksArray.removeAll{ $0 == currentNews }
            
            print("Массив избранное =", bookmarksManager.bookmarksArray.count)
        } else {
            favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            liked = true
            bookmarksManager.bookmarksArray.append(currentNews!)
            print("Массив избранное =", bookmarksManager.bookmarksArray.count)
        }
        delegateFavoriteButton?.favouriteButtonTapped()
    }
    
    func configure(_ news: Result) {
        if let imageURL = news.imageURL {
            self.newsImageView.kf.setImage(with: URL(string: imageURL))
        } else {
            newsImageView.image = UIImage(named: "NoImage")
        }
        self.newsTitleLabel.text = news.title
        self.categoryLabel.text = news.category?.first?.capitalized
        self.currentNews = news
        layoutSubviews()
    }
    
    private func configureNewsImageView() {
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.image = UIImage(named: "CellImage")
        newsImageView.contentScaleFactor = 1.0
        newsImageView.layer.cornerRadius = 20
        newsImageView.layer.masksToBounds = true
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTitleLabel() {
        newsTitleLabel.text = "The latest situation in the presedential election"
        newsTitleLabel.numberOfLines = 0
        newsTitleLabel.textAlignment = .left
        newsTitleLabel.font = UIFont.systemFont(ofSize: 16)
        newsTitleLabel.adjustsFontSizeToFitWidth = true
        newsTitleLabel.minimumScaleFactor = 0.7
        newsTitleLabel.textColor = .black
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureCategoryLabel() {
        categoryLabel.text = "Without category"
        categoryLabel.textAlignment = .left
        categoryLabel.font = UIFont.systemFont(ofSize: 14)
        categoryLabel.textColor = .black
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Set constraints and add Subview
extension RecommendedCell {
    
    func setupView() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(favouriteButton)
        configureFavouriteButton()
        configureNewsImageView()
        configureTitleLabel()
        configureCategoryLabel()
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            newsImageView.widthAnchor.constraint(equalToConstant: 90),
            newsImageView.heightAnchor.constraint(equalToConstant: 90),
            
            newsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -25),
            newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor,constant: 15),
            newsTitleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            
            categoryLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 15),
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            
            favouriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            favouriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            favouriteButton.widthAnchor.constraint(equalToConstant: 20),
            favouriteButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
