//
//  BookmarksViewController.swift
//  NewsToDay
//
//  Created by Vitali Martsinovich on 2023-05-09.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    private let bookmarksView = BookmarksView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.bookmarksView.tableView.reloadData()
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
}
