//
//  CategoryViewController.swift
//  NewsToDay
//
//  Created by Леонид Турко on 12.05.2023.
//

import UIKit

class CategoryViewController: UIViewController {
  //  MARK: - UI Elements
  private lazy var verticalStack: UIStackView = {
    let element = UIStackView()
    element.axis = .vertical
    element.spacing = 8
    return element
  }()
  
  private lazy var topicLabel: UILabel = {
    let element = UILabel()
    element.text = "Select your favorite topics"
    element.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    return element
  }()
  
  private lazy var messageLabel: UILabel = {
    let element = UILabel()
    element.text = "Select some of your favorite topics to let us suggest better news for you."
    element.font = UIFont.systemFont(ofSize: 20)
    element.textColor = #colorLiteral(red: 0.5589404702, green: 0.5851458907, blue: 0.692604959, alpha: 1)
    element.numberOfLines = 0
    return element
  }()
  
  private lazy var nextButton: UIButton = {
    let element = UIButton(type: .system)
    element.setTitle("Next", for: .normal)
    element.backgroundColor = #colorLiteral(red: 0.3483863771, green: 0.4508807063, blue: 0.8743079901, alpha: 1)
    element.tintColor = .white
    element.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    element.layer.cornerRadius = 12
    return element
  }()
  
  private lazy var containerView: UIView = {
    let element = UIView()
    return element
  }()
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let element = UICollectionView(frame: containerView.frame, collectionViewLayout: layout)
    element.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
    element.backgroundColor = .white
    element.allowsMultipleSelection = true
    return element
  }()

  //  MARK: - Private Properties
  private let dataSource = DataSource()
  private let delegate = CategoryViewControllerDelegate()
  
  //  MARK: - Override Methods
  override func viewDidLoad() {
      super.viewDidLoad()
    setViews()
    setConstraints()
    setCollectionDelegates()
  }
}

//  MARK: -  Private Methods
extension CategoryViewController {
  private func setCollectionDelegates() {
    collectionView.delegate = delegate
    collectionView.dataSource = dataSource
  }
  
  private func setViews() {
    containerView.addSubview(collectionView)
    view.addSubview(containerView)
    view.addSubview(verticalStack)
    view.addSubview(nextButton)
    verticalStack.addArrangedSubview(topicLabel)
    verticalStack.addArrangedSubview(messageLabel)
  }
  
  private func setConstraints() {
    nextButton.snp.makeConstraints { make in
      make.top.equalTo(containerView.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(35)
      make.height.equalTo(56)
    }
    
    verticalStack.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(72)
      make.leading.trailing.equalToSuperview().inset(20)
    }
    
    containerView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalToSuperview().inset(200)
      make.height.equalTo(450)
    }
    
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
