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
        bookmarksView.tableView.dataSource = self
        bookmarksView.tableView.delegate = self
        bookmarksView.tableView.register(RecommendedCell.self, forCellReuseIdentifier: RecommendedCell.identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(BookmarksManager.favouriteArray.count)
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

// MARK: - TableView Delegate
extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if BookmarksManager.favouriteArray.isEmpty {
            bookmarksView.emptyLabel.isHidden = false
            bookmarksView.circleView.isHidden = false
        } else {
            bookmarksView.emptyLabel.isHidden = true
            bookmarksView.circleView.isHidden = true
        }
        return BookmarksManager.favouriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendedCell.identifier, for: indexPath) as? RecommendedCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.liked = true
        let savedNews = BookmarksManager.favouriteArray[indexPath.row]
        if BookmarksManager.favouriteArray.contains(savedNews) {
            cell.favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            cell.favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        cell.delegateFavoriteButton = self
        cell.configure(savedNews)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension BookmarksViewController: FavouriteButtonProtocol {
    func favouriteButtonTapped() {
        print("tapped")
        self.bookmarksView.tableView.reloadData()
    }
}

