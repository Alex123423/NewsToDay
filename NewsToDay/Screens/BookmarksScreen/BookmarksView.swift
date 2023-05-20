//
//  BookmarksView.swift
//  NewsToDay
//
//  Created by Vitali Martsinovich on 2023-05-10.
//

import UIKit
import SnapKit

class BookmarksView: UIView {
    
    var tableView = UITableView()
    let topTitleLabel = UILabel()
    let topSublabel = UILabel()
    let emptyLabel = UILabel()
    let circleView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name("LanguageChangedNotification"), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuring UI elements
    private func setupViews() {
        configureTable()
        configureToptitleLabel()
        configureTopSublabel()
        configureEmptyLabel()
        configureCircle()
    }
    
    func configureTable() {
        self.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureCircle() {
        self.addSubview(circleView)
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
        self.addSubview(topTitleLabel)
        topTitleLabel.text = "Bookmarks".localized
        topTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        topTitleLabel.textColor = .black
        topTitleLabel.textAlignment = .left
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTopSublabel() {
        self.addSubview(topSublabel)
        topSublabel.text = "Saved articles to the library".localized
        topSublabel.font = .systemFont(ofSize: 16)
        topSublabel.textColor = UIColor(named: Resources.Colors.gray)
        topSublabel.textAlignment = .left
        topSublabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureEmptyLabel() {
        self.addSubview(emptyLabel)
        emptyLabel.text = "You haven't saved any articles yet. Start reading and bookmarking them now".localized
        emptyLabel.numberOfLines = 0
        emptyLabel.font = .systemFont(ofSize: 16)
        emptyLabel.textColor = UIColor(named: Resources.Colors.darkGray)
        emptyLabel.textAlignment = .center
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            topTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            topTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            topSublabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            topSublabel.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: topSublabel.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            circleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: self.topAnchor, constant: (self.frame.size.height * 0.5) - 40),
            
            emptyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            emptyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            emptyLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 25)
        ])
    }
    
    @objc func updateLanguage() {
        topTitleLabel.text = "Bookmarks".localized
        topSublabel.text = "Saved articles to the library".localized
        emptyLabel.text = "You haven't saved any articles yet. Start reading and bookmarking them now".localized
    }
}
