//
//  RecommendedCell.swift
//  NewsAPI
//
//  Created by Vitali Martsinovich on 2023-05-06.
//

import UIKit
import Kingfisher

class RecommendedCell: UITableViewCell {
    
    static let identifier = "RecommendedCell"
    
    var liked: Bool = false
    
    private let newsImageView = UIImageView()
    private let newsTitleLabel = UILabel()
    private let favouriteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupView()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ article: Result) {
        self.newsTitleLabel.text = article.title
        if let imageURL = article.imageURL, let url = URL(string: imageURL) {
            self.newsImageView.kf.setImage(with: url)
        } else {
            self.newsImageView.image = UIImage(named: "CellImage")
        }
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
        } else {
            favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            liked = true
        }
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
        newsTitleLabel.font = UIFont(name: "Arial", size: 16)
        newsTitleLabel.textColor = .black
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Set constraints and add Subview
extension RecommendedCell {
    
    func setupView() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(favouriteButton)
        configureFavouriteButton()
        configureNewsImageView()
        configureTitleLabel()
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            newsImageView.widthAnchor.constraint(equalToConstant: 90),
            newsImageView.heightAnchor.constraint(equalToConstant: 90),
            
            newsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor,constant: 15),
            newsTitleLabel.centerYAnchor.constraint(equalTo: newsImageView.centerYAnchor),
            
            favouriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            favouriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            favouriteButton.widthAnchor.constraint(equalToConstant: 20),
            favouriteButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
