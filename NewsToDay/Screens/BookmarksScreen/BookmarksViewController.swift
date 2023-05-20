//
//  BookmarksViewController.swift
//  NewsToDay
//
//  Created by Vitali Martsinovich on 2023-05-09.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    private let bookmarksView = BookmarksView()
    let bookmarksManager = BookmarksManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupDelegates()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name("LanguageChangedNotification"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.bookmarksView.tableView.reloadData()
        }
    }
    
    //MARK: - Setting up UI elements
    
    private func setupDelegates() {
        bookmarksView.tableView.dataSource = self
        bookmarksView.tableView.delegate = self
    }
    
    private func setupViews() {
        bookmarksView.tableView.register(RecommendedCell.self, forCellReuseIdentifier: RecommendedCell.identifier)
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

// MARK: - TableView Delegate&DataSource
extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookmarksManager.bookmarksArray.isEmpty {
            bookmarksView.emptyLabel.isHidden = false
            bookmarksView.circleView.isHidden = false
        } else {
            bookmarksView.emptyLabel.isHidden = true
            bookmarksView.circleView.isHidden = true
        }
        return bookmarksManager.bookmarksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendedCell.identifier, for: indexPath) as? RecommendedCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.liked = true
        let savedNews = bookmarksManager.bookmarksArray[indexPath.row]
        if bookmarksManager.bookmarksArray.contains(savedNews) {
            cell.favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            cell.favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        cell.delegateFavoriteButton = self
        cell.configure(savedNews)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailedViewController()
        DispatchQueue.main.async {
            vc.configureScreen(selectedArticle: self.bookmarksManager.bookmarksArray[indexPath.row])
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

//MARK: - Delegate favourite button
extension BookmarksViewController: FavouriteButtonProtocol {
    
    func favouriteButtonTapped() {
        self.bookmarksView.tableView.reloadData()
    }
}
