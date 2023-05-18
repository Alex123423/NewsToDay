//
//  ArticleViewController.swift
//  NewsToDay
//
//  Created by Леонид Турко on 10.05.2023.
//

import UIKit
import Kingfisher
import SafariServices

class DetailedViewController: UIViewController {
    
    let bookmarksManager = BookmarksManager.shared
    var liked: Bool = false
    var currentNews: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
    }
    
    func configureScreen(selectedArticle: Result) {
        if let imageURL = selectedArticle.imageURL {
            self.newsImage.kf.setImage(with: URL(string: imageURL))
        } else {
            self.newsImage.image = UIImage(named: Resources.Images.noImage)
        }
        self.newsText.text = selectedArticle.content
        self.titleLabel.text = selectedArticle.title
        self.creatorLabel.text = selectedArticle.creator?.first ?? "Not specified"
        self.categoryName.text = selectedArticle.category?.first?.capitalized
        if bookmarksManager.bookmarksArray.contains(selectedArticle) {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            liked = true
        } else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        currentNews = selectedArticle
    }
    
    @objc func favouriteButtonPressed() {
        if liked {
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            liked = false
            bookmarksManager.bookmarksArray.removeAll { $0 == currentNews }
        } else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            liked = true
            bookmarksManager.bookmarksArray.append(currentNews!)
        }
    }
    
    @objc func arrowBackTapped() {
        self.dismiss(animated: false)
    }
    
    @objc func shareButtonTapped() {
        guard let urlString = currentNews?.link,
              let url = URL(string: urlString) else { return }

        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    //  MARK: - UI Views
    
    private lazy var newsImage: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.backgroundColor = .red
        return element
    }()
    
    private lazy var newsText: UITextView = {
        let element = UITextView()
        let text = Message()
        element.backgroundColor = .clear
        element.text = text.text
        element.textColor = UIColor(named: Resources.Colors.gray)
        element.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        element.showsVerticalScrollIndicator = false
        return element
    }()
    
    //  MARK: - UI Buttons
    
    private lazy var bookmarkButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(named: "bookmark"), for: .normal)
        element.tintColor = .white
        element.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        return element
    }()
    
    private lazy var arrowButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(named: "rightarrow"), for: .normal)
        element.tintColor = .white
        element.addTarget(self, action: #selector(loadData), for: .touchUpInside)
        return element
    }()
    
    private lazy var arrowBackbutton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(named: Resources.Images.backArrow), for: .normal)
        element.tintColor = .white
        element.addTarget(self, action: #selector(arrowBackTapped), for: .touchUpInside)
        return element
    }()
    
    private lazy var shareButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Share", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        element.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return element
    }()
    
    //  MARK: - UI Labels
    private lazy var categoryName: UILabel = {
        let element = UILabel()
        element.backgroundColor = UIColor(named: Resources.Colors.button)
        element.text = "Politics"
        element.textColor = .white
        element.textAlignment = .center
        element.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        element.layer.cornerRadius = 16
        element.clipsToBounds = true
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.text = "The latest situation in the presidential election"
        element.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var creatorLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.text = "John Doe"
        element.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var authorLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.text = "Author"
        element.font = UIFont.systemFont(ofSize: 14)
        element.textColor = #colorLiteral(red: 0.7300543189, green: 0.7426104546, blue: 0.8079518676, alpha: 1)
        element.numberOfLines = 0
        return element
    }()
}

//  MARK: -  Private Methods
extension DetailedViewController {
    private func setViews() {
        view.backgroundColor = .white
        view.addSubview(newsImage)
        view.addSubview(newsText)
        newsImage.addSubview(authorLabel)
        newsImage.addSubview(creatorLabel)
        newsImage.addSubview(titleLabel)
        newsImage.addSubview(categoryName)
        newsImage.addSubview(arrowBackbutton)
        newsImage.addSubview(bookmarkButton)
        newsImage.addSubview(arrowButton)
        newsImage.addSubview(shareButton)
        newsImage.isUserInteractionEnabled = true
    }
    
    private func setConstraints() {
        
        newsImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height / 2 - 60)
        }
        
        newsText.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        arrowBackbutton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(26)
            make.top.equalToSuperview().offset(78)
            make.height.width.equalTo(12)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-26)
            make.centerY.equalTo(arrowBackbutton)
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-26)
            make.top.equalTo(bookmarkButton.snp.bottom).offset(30)
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        
        shareButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-26)
            make.centerY.equalTo(categoryName.snp.centerY)
            make.height.equalTo(30)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.left.equalToSuperview().offset(26)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.bottom.equalTo(authorLabel).inset(15)
            make.left.equalToSuperview().offset(26)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(creatorLabel.snp.top).offset(-25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        categoryName.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-15)
            make.leading.equalTo(20)
            make.height.equalTo(32)
            make.width.equalTo(120)
        }
    }
}

extension DetailedViewController {
    func presentOkAlertWithMessage(_ message: String) {
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    
    @objc func loadData() {

        guard let article = currentNews, let urlString = article.link, let url = URL(string: urlString) else {
            self.presentOkAlertWithMessage("Invalid news URL")
            return
        }
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
}

