//
//  BookmarksViewController.swift
//  NewsToDay
//
//  Created by Vitali Martsinovich on 2023-05-09.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    private let tableView = RecommendedTableView()
    private let topTitleLabel = UILabel()
    private let topSublabel = UILabel()
    private let emptyLabel = UILabel()
    private let circleView = UIView()

    var savedNews: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if savedNews.isEmpty {
            tableView.isHidden = true
            emptyLabel.isHidden = false
            circleView.isHidden = false
        } else {
            emptyLabel.isHidden = true
            circleView.isHidden = true
        }
    }
    
    //MARK: - Configuring UI elements
    private func configureCircle() {
        view.addSubview(circleView)
        circleView.widthAnchor.constraint(equalToConstant: 72).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        circleView.backgroundColor = UIColor(named: Resources.Colors.grayLighter)
        circleView.layer.cornerRadius = 36
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: UIImage(named: "book"))
        circleView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
    }
    
    private func configureToptitleLabel() {
        view.addSubview(topTitleLabel)
        topTitleLabel.text = "Bookmarks"
        topTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        topTitleLabel.textColor = .black
        topTitleLabel.textAlignment = .left
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTopSublabel() {
        view.addSubview(topSublabel)
        topSublabel.text = "Saved articles to the library"
        topSublabel.font = .systemFont(ofSize: 16)
        topSublabel.textColor = UIColor(named: Resources.Colors.gray)
        topSublabel.textAlignment = .left
        topSublabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureEmptyLabel() {
        view.addSubview(emptyLabel)
        emptyLabel.text = "You haven't saved any articles yet. Start reading and bookmarking them now"
        emptyLabel.numberOfLines = 0
        emptyLabel.font = .systemFont(ofSize: 16)
        emptyLabel.textColor = UIColor(named: Resources.Colors.darkGray)
        emptyLabel.textAlignment = .center
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    //MARK: - Setting up UI elements
    
    private func setupViews() {
        view.backgroundColor = .white
        configureToptitleLabel()
        configureTopSublabel()
        configureEmptyLabel()
        configureCircle()
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            topTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            topSublabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            topSublabel.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: topSublabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 2 - 60),
            
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            emptyLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 25)
            
            
            
        ])
    }
}
