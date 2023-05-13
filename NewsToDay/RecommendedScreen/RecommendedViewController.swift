//
//  RecommendedViewController.swift
//  NewsToDay
//
//  Created by Vitali Martsinovich on 2023-05-10.
//

import UIKit

class RecommendedViewController: UIViewController {
    
    private let tableView = RecommendedTableView()
    private let topTitleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        getRecommendedNews()
    }
    
    private func configureToptitleLabel() {
        view.addSubview(topTitleLabel)
        topTitleLabel.text = "Recommended for you".localized
        topTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        topTitleLabel.textColor = .black
        topTitleLabel.textAlignment = .left
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func getRecommendedNews() {
        RequestsManager.shared.getNewsByRecommend(category: CategoriesManager.categories.joined(separator: ",")) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newsData):
                DispatchQueue.main.async {
                    self.tableView.news = newsData.results
                    self.tableView.reloadData()
                    print("get news")
                }
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(topTitleLabel)
        configureToptitleLabel()
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            topTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            topTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            tableView.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}
