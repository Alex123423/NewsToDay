//
//  CategoriesOnCell.swift
//  NewsToDay
//
//  Created by Александра Савчук on 11.05.2023.
//

import UIKit

class CategoriesOnCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
}

extension CategoriesOnCell {
    private func addSubviews() {
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            label.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            )
        ])
    }
    
    private func configureCell() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(
            red: 0.953, green: 0.955, blue: 0.967, alpha: 1
        )
        
        label.textColor = UIColor(
            red: 0.401, green: 0.425, blue: 0.559, alpha: 1
        )
        label.font = .boldSystemFont(ofSize: 16)
    }
}

extension CategoriesOnCell {
    func set(title: String) {
        label.text = title
    }
    
    func activate() {
        self.backgroundColor = UIColor(named: Resources.Colors.button)
        label.textColor = .white
    }
    
    func deactivate() {
        self.backgroundColor = UIColor(named: Resources.Colors.grayLighter)
        label.textColor = UIColor(named: Resources.Colors.gray)
    }
    
    func error() {
        self.backgroundColor = UIColor.red
        label.textColor = .white
    }
}
