//
//  BookmarksViewController.swift
//  NewsToDay
//
//  Created by Vitali Martsinovich on 2023-05-09.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    private let bookmarksView = BookmarksView()

    var savedNews: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if savedNews.isEmpty {
            bookmarksView.tableView.isHidden = true
            bookmarksView.emptyLabel.isHidden = false
            bookmarksView.circleView.isHidden = false
        } else {
            bookmarksView.emptyLabel.isHidden = true
            bookmarksView.circleView.isHidden = true
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
        topTitleLabel.text = "Bookmarks".localized
        topTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        topTitleLabel.textColor = .black
        topTitleLabel.textAlignment = .left
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTopSublabel() {
        view.addSubview(topSublabel)
        topSublabel.text = "Saved articles to the library".localized
        topSublabel.font = .systemFont(ofSize: 16)
        topSublabel.textColor = UIColor(named: Resources.Colors.gray)
        topSublabel.textAlignment = .left
        topSublabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureEmptyLabel() {
        view.addSubview(emptyLabel)
        emptyLabel.text = "You haven't saved any articles yet. Start reading and bookmarking them now".localized
        emptyLabel.numberOfLines = 0
        emptyLabel.font = .systemFont(ofSize: 16)
        emptyLabel.textColor = UIColor(named: Resources.Colors.darkGray)
        emptyLabel.textAlignment = .center
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    //MARK: - Setting up UI elements
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(bookmarksView)
    }
    
    private func setupConstraints() {
        bookmarksView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookmarksView.topAnchor.constraint(equalTo: view.topAnchor),
            bookmarksView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookmarksView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bookmarksView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
