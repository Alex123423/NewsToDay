//
//  CategoryViewControllerDelegate.swift
//  NewsToDay
//
//  Created by Леонид Турко on 12.05.2023.
//

import UIKit

class CategoryViewControllerDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      CGSize(width: 160, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell else { return }
      cell.textLabel.textColor = .white
      cell.backgroundColor = #colorLiteral(red: 0.3483863771, green: 0.4508807063, blue: 0.8743079901, alpha: 1)
    }
}
