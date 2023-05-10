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
        image.image = UIImage(named: "CellImage")
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
        } else {
            favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            liked = true
        }
    }
    
    func configureCell(_ newsData: Result) {
        DispatchQueue.main.async {
            self.titleLabel.text = newsData.title
            guard let imageURL = newsData.imageURL else { return }
            self.newsImageView.kf.setImage(with: URL(string: imageURL))
        }
    }
    
    private func setupViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(titleLabel)
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
            
            favouriteButton.heightAnchor.constraint(equalToConstant: 25),
            favouriteButton.widthAnchor.constraint(equalToConstant: 25),
            favouriteButton.topAnchor.constraint(equalTo: newsImageView.topAnchor, constant: 20),
            favouriteButton.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor,constant: -20)
        ])
    }
}
