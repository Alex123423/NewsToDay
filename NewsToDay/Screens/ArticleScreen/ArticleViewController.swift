//
//  ArticleViewController.swift
//  NewsToDay
//
//  Created by Леонид Турко on 10.05.2023.
//

import UIKit

class ArticleViewController: UIViewController {
  //  MARK: - UI Views
  private lazy var mainView: UIView = {
    let element = UIView()
    element.backgroundColor = .blue
    return element
  }()
  
  private lazy var imageView: UIImageView = {
    let element = UIImageView()
    element.image = UIImage(named: "building")
    element.contentMode = .scaleToFill
    return element
  }()
  
  private lazy var textView: UITextView = {
    let element = UITextView()
    let text = Message()
    element.text = text.text
    element.textColor = #colorLiteral(red: 0.5589404702, green: 0.5851458907, blue: 0.692604959, alpha: 1)
    element.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    element.showsVerticalScrollIndicator = false
    return element
  }()
  
  //  MARK: - UI Buttons
  private lazy var themeButton: UIButton = {
    let element = UIButton(type: .system)
    element.backgroundColor = #colorLiteral(red: 0.3483863771, green: 0.4508807063, blue: 0.8743079901, alpha: 1)
    element.setTitle("Politics", for: .normal)
    element.setTitleColor(.white, for: .normal)
    element.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    element.layer.cornerRadius = 16
    return element
  }()
  
  private lazy var bookmarkButton: UIButton = {
    let element = UIButton(type: .system)
    element.setImage(UIImage(named: "bookmark"), for: .normal)
    element.tintColor = .white
    return element
  }()
  
  private lazy var arrowButton: UIButton = {
    let element = UIButton(type: .system)
    element.setImage(UIImage(named: "rightarrow"), for: .normal)
    element.tintColor = .white
    return element
  }()
  
  //  MARK: - UI Labels
  private lazy var themeLabel: UILabel = {
    let element = UILabel()
    element.textColor = .white
    element.text = "The latest situation in the presidential election"
    element.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    element.numberOfLines = 0
    return element
  }()
  
  private lazy var nameLabel: UILabel = {
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
  
  private lazy var resultLabel: UILabel = {
    let element = UILabel()
    element.textColor = #colorLiteral(red: 0.2602780759, green: 0.2769176066, blue: 0.349611342, alpha: 1)
    element.text = "Results"
    element.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    element.numberOfLines = 0
    return element
  }()
  
  //  MARK: - UI StackViews
  private lazy var labelsStackView: UIStackView = {
    let element = UIStackView()
    element.axis = .vertical
    return element
  }()
  
  private lazy var buttonsStackView: UIStackView = {
    let element = UIStackView()
    element.axis = .vertical
    element.spacing = 25
    element.distribution = .fillEqually
    return element
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setViews()
    setConstraints()
  }
}

//  MARK: -  Private Methods
extension ArticleViewController {
  private func setViews() {
    mainView.addSubview(imageView)
    mainView.addSubview(themeButton)
    mainView.addSubview(themeLabel)
    mainView.addSubview(labelsStackView)
    mainView.addSubview(buttonsStackView)
    labelsStackView.addArrangedSubview(nameLabel)
    labelsStackView.addArrangedSubview(authorLabel)
    buttonsStackView.addArrangedSubview(bookmarkButton)
    buttonsStackView.addArrangedSubview(arrowButton)
    view.addSubview(mainView)
    view.addSubview(resultLabel)
    view.addSubview(textView)
  }
  
  private func setConstraints() {
    textView.snp.makeConstraints { make in
      make.top.equalTo(resultLabel.snp.bottom).offset(8)
      make.leading.equalTo(resultLabel.snp.leading)
      make.trailing.equalToSuperview().offset(-20)
      make.height.equalTo(500)
    }
    
    resultLabel.snp.makeConstraints { make in
      make.top.equalTo(mainView.snp.bottom).offset(24)
      make.leading.equalToSuperview().offset(20)
    }
    bookmarkButton.snp.makeConstraints { make in
      make.width.equalTo(40)
      make.height.equalTo(30)
    }
    
    buttonsStackView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(74)
      make.trailing.equalToSuperview().offset(-24)
    }
    
    labelsStackView.snp.makeConstraints { make in
      make.top.equalTo(themeLabel.snp.bottom).offset(24)
      make.leading.equalToSuperview().inset(20)
    }
    
    themeLabel.snp.makeConstraints { make in
      make.top.equalTo(themeButton.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview().inset(20)
    }
    
    themeButton.snp.makeConstraints { make in
      make.leading.equalTo(20)
      make.top.equalTo(168)
      make.height.equalTo(32)
      make.width.equalTo(90)
    }
    
    imageView.snp.makeConstraints { make in
      make.top.bottom.leading.trailing.equalToSuperview()
    }
    
    mainView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(384)
    }
  }
}

