//
//  NewsCell.swift
//  NewsAPI
//
//  Created by Vitali Martsinovich on 2023-05-05.
//

import UIKit
import Kingfisher

class NewsCell: UICollectionViewCell {
    
    var liked: Bool = false
    static let identifier = "NewsCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let newsImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "NoImage")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "The latest situation in the presedential election"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Without category"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func favouriteButtonPressed() {
        if liked {
            favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            liked = false
            BookmarksManager.shared.favouriteArray.removeAll { $0 == BookmarksManager.shared.currentNews }
            print("Массив избранное =", BookmarksManager.shared.favouriteArray.count)
        } else {
            favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            liked = true
            BookmarksManager.shared.favouriteArray.append(BookmarksManager.shared.currentNews!)
            print("Массив избранное =", BookmarksManager.shared.favouriteArray.count)

        }
    }
    
    func configureCell(_ newsData: Result) {
        DispatchQueue.main.async {
            self.titleLabel.text = newsData.title
            self.categoryLabel.text = newsData.category?.first?.uppercased() ?? "Without category"
            if let imageURL = newsData.imageURL {
                self.newsImageView.kf.setImage(with: URL(string: imageURL))
            } else {
                self.newsImageView.image = UIImage(named: "NoImage")
            }
            BookmarksManager.shared.currentNews = newsData
        }
    }
    
    private func setupViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topAnchor,constant: 0),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            titleLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: -15),
            titleLabel.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: -24),
            
            categoryLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: 15),
            categoryLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5),
            
            favouriteButton.heightAnchor.constraint(equalToConstant: 25),
            favouriteButton.widthAnchor.constraint(equalToConstant: 25),
            favouriteButton.topAnchor.constraint(equalTo: newsImageView.topAnchor, constant: 20),
            favouriteButton.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor,constant: -20)
        ])
    }
}
