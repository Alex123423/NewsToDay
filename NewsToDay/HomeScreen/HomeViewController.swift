//
//  HomeViewController.swift
//  NewsAPI
//
//  Created by Vitali Martsinovich on 2023-05-04.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController  {
    
    private let collectionView = CategoriesCollection()
    private let middleCollectionView = MiddleCollectionView()
    private let topTitleLabel = UILabel()
    private let topSublabel = UILabel()
    private let searchTextField = SearchTextField()
    private let searchImageView = UIImageView()
    private let bottomTitleLabel = UILabel()
    private let seeAllButton = UIButton(type: .system)
    private let recommendedTableView = RecommendedTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        collectionView.delegateCollectionDidSelect = self
        randomNews()
    }
    
    //MARK: - Configuring UI Elements
    
    private func setupViews() {
        configureToptitleLabel()
        configureTopSublabel()
        configureBottomLabel()
        configureSeeAllButton()
        view.addSubview(searchTextField)
        view.addSubview(collectionView)
        view.addSubview(middleCollectionView)
        view.addSubview(bottomTitleLabel)
        view.addSubview(seeAllButton)
        view.addSubview(recommendedTableView)
    }
    
    private func configureToptitleLabel() {
        view.addSubview(topTitleLabel)
        topTitleLabel.text = "Browse".localized
        topTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        topTitleLabel.textColor = .black
        topTitleLabel.textAlignment = .left
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTopSublabel() {
        view.addSubview(topSublabel)
        topSublabel.text = "Discover things of this world".localized
        topSublabel.font = .systemFont(ofSize: 16)
        topSublabel.textColor = UIColor(named: Resources.Colors.gray)
        topSublabel.textAlignment = .left
        topSublabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureBottomLabel() {
        view.addSubview(bottomTitleLabel)
        bottomTitleLabel.text = "Recommended for you".localized
        bottomTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        bottomTitleLabel.textColor = .black
        bottomTitleLabel.textAlignment = .left
        bottomTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureSeeAllButton() {
        view.addSubview(seeAllButton)
        seeAllButton.titleLabel?.font = .systemFont(ofSize: 14)
        seeAllButton.tintColor = UIColor(named: Resources.Colors.gray)
        seeAllButton.setTitle("See all".localized, for: .normal)
        seeAllButton.addTarget(self, action: #selector(seeAllPressed), for: .touchUpInside)
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func seeAllPressed(sender: UIButton) {
        
    }
    
    //MARK: - Constraints
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        middleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        recommendedTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            topTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            topSublabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            topSublabel.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 10),
            
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            searchTextField.heightAnchor.constraint(equalToConstant: 56),
            searchTextField.topAnchor.constraint(equalTo: topSublabel.bottomAnchor, constant: 30),
            
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 15),
            collectionView.heightAnchor.constraint(equalToConstant: 40),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            middleCollectionView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15),
            middleCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            middleCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            middleCollectionView.heightAnchor.constraint(equalToConstant: 260),
            
            bottomTitleLabel.topAnchor.constraint(equalTo: middleCollectionView.bottomAnchor, constant: 15),
            bottomTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            seeAllButton.topAnchor.constraint(equalTo: middleCollectionView.bottomAnchor, constant: 15),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            recommendedTableView.topAnchor.constraint(equalTo: bottomTitleLabel.bottomAnchor, constant: 20),
            recommendedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            recommendedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            recommendedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - Network requests

extension HomeViewController: CollectionDidSelectProtocol {
    
    // get news for random category
    func randomNews() {
        RequestsManager.shared.getTopNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newsData):
                self.middleCollectionView.news.removeAll()
                DispatchQueue.main.async {
                    self.middleCollectionView.news = newsData.articles
                    self.middleCollectionView.collectionView.reloadData()
                    
                }
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
    }
    
    func getNewsFromCategory(categoryName: String) {
        if categoryName == "Random" {
            RequestsManager.shared.getTopNews { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let newsData):
                    self.middleCollectionView.news.removeAll()
                    DispatchQueue.main.async {
                        self.middleCollectionView.news = newsData.articles
                        self.middleCollectionView.collectionView.reloadData()
                        
                    }
                case .failure(let error):
                    print("Error fetching news data: \(error)")
                }
            }
        } else {
            RequestsManager.shared.getNewsByCategory(category: categoryName) { [weak self] result in
                print(categoryName)
                print(result)
                guard let self = self else { return }
                switch result {
                case .success(let newsData):
                    self.middleCollectionView.news.removeAll()
                    DispatchQueue.main.async {
                        self.middleCollectionView.news.append(contentsOf: newsData.articles)
                        self.middleCollectionView.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
