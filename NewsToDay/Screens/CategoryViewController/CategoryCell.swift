//
//  CategoryCell.swift
//  NewsToDay
//
//  Created by Леонид Турко on 12.05.2023.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: CategoryCell.self)
  var isEditing = false
  
  var textLabel: UILabel = {
    let element = UILabel()
    element.textColor = .blue
    element.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    return element
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setViews()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CategoryCell {
  private func setViews() {
    contentView.addSubview(textLabel)
  }
  
  private func setConstraints() {
    textLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}
