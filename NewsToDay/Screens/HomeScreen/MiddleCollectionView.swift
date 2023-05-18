//
//  MiddleCollectionView.swift
//  NewsAPI
//
//  Created by Vitali Martsinovich on 2023-05-05.
//

import UIKit
import SnapKit

class MiddleCollectionView: UIView {
    
    var collectionView: UICollectionView!
    let bookmarksManager = BookmarksManager.shared
    
    weak var parentViewController: HomeViewController?
    
    var news: [Result] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollection()
        self.addSubview(collectionView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MiddleCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {
            return UICollectionViewCell()
        }
        let selectedNews = news[indexPath.row]
        if bookmarksManager.bookmarksArray.contains(selectedNews) {
            cell.liked = true
            cell.favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            cell.favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        cell.configureCell(news[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let parentViewController = parentViewController else {
                return
            }

        let selectedArticle = self.news[indexPath.row]
            let vc = DetailedViewController()
            vc.configureScreen(selectedArticle: selectedArticle)
            vc.modalPresentationStyle = .fullScreen
            parentViewController.present(vc, animated: true)
        }
}

