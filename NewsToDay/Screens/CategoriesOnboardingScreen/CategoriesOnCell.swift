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
        self.backgroundColor = UIColor(
            red: 0.278, green: 0.353, blue: 0.842, alpha: 1
        )
        label.textColor = .white
    }
    
    func deactivate() {
        self.backgroundColor = UIColor(
            red: 0.953, green: 0.955, blue: 0.967, alpha: 1
        )
        label.textColor = UIColor(
            red: 0.401, green: 0.425, blue: 0.559, alpha: 1
        )
    }
    
    func error() {
        self.backgroundColor = UIColor.red
        label.textColor = .white
    }
}


//class CategoriesOnCell: UICollectionViewCell {
//
//    // MARK: - Properties
//
//    let label: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
//        label.textAlignment = .center
//        label.layer.borderWidth = 0.5
//        label.layer.borderColor = UIColor.lightGray.cgColor
//        label.layer.cornerRadius = 12
//        label.clipsToBounds = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    override var isSelected: Bool {
//            didSet {
//                backgroundColor = isSelected ? .blue : .clear
//                label.textColor = isSelected ? .white : .black
//            }
//        }
//
//    // MARK: - Initialization
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(label)
//        NSLayoutConstraint.activate([
//
//            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//            label.topAnchor.constraint(equalTo: contentView.topAnchor),
//            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
//        ])
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
