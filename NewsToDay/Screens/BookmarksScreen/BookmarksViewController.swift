//
//  BookmarksViewController.swift
//  NewsToDay
//
//  Created by Vitali Martsinovich on 2023-05-09.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    private let bookmarksView = BookmarksView()

    var savedNews: [Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name("LanguageChangedNotification"), object: nil)
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
    
    @objc func updateLanguage() {
        bookmarksView.reloadInputViews()
    }
}
