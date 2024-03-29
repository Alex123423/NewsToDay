//
//  MyCollectionView.swift
//  ch 3 MovieWatcher
//
//  Created by Vitali Martsinovich on 2023-04-07.
//

import UIKit
import SnapKit

class CategoriesCollection: UIView {
    
    private var collectionView: UICollectionView!
    weak var delegateCollectionDidSelect: CollectionDidSelectProtocol?
    
    private var categories = ["Random", "Politics", "Business", "Top", "Environment", "Entertainment", "Food", "Health", "Science", "Sports", "Tourism", "Technology", "World"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollection()
        setCollectionDelegates()
        self.addSubview(collectionView)
        setupConstraints()
        makeFirstCellActive()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name("LanguageChangedNotification"), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    func setCollectionDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func makeFirstCellActive() {
        let firstIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .centeredHorizontally)
    }
}

//MARK: - Protocols
protocol CollectionDidSelectProtocol: AnyObject {
    func getNewsFromCategory(categoryName: String)
}

extension CategoriesCollection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        let category = categories[indexPath.row]
        cell.configure(with: category.localized)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categories[indexPath.row]
        let cellWidth = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16) as Any]).width + 40
        return CGSize(width: cellWidth, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegateCollectionDidSelect?.getNewsFromCategory(categoryName: categories[indexPath.item].lowercased())
    }
    
    @objc func updateLanguage() {
        collectionView.reloadData()
    }
}
