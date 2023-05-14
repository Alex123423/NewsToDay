//
//  CategoryCell.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-05.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(named: Resources.Colors.gray)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = UIColor(named: Resources.Colors.button)
                categoryLabel.textColor = .white
                layer.borderColor = UIColor(named: Resources.Colors.button)?.cgColor
                
            } else {
                backgroundColor = UIColor(named: Resources.Colors.grayLighter)
                categoryLabel.textColor = UIColor(named: Resources.Colors.gray)
                layer.borderColor = UIColor(named: Resources.Colors.grayLighter)?.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupUICell()
    }
    
    func setupUICell() {
        backgroundColor = UIColor(named: Resources.Colors.grayLighter)
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: Resources.Colors.grayLighter)?.cgColor
        layer.masksToBounds = false
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with title: String) {
        categoryLabel.text = title
    }
    
    private func setupViews() {
        contentView.addSubview(categoryLabel)
    }
    
    private func setupConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
