//
//  UICollectionView+Extension.swift
//  Mogakco
//
//  Created by taekki on 2022/11/08.
//

import UIKit

extension UICollectionView {
    // MARK: - UICollectionViewCell
    
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell> (
        cellType: T.Type = T.self,
        for indexPath: IndexPath
    ) -> T {
        let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
        
        guard let cell = cell as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self).")
        }
        return cell
    }
    
    // MARK: - UICollectionReusableView
    
    func register<T: UICollectionReusableView> (
        _ supplementaryViewType: T.Type,
        ofKind elementKind: String
    ) {
        self.register(
            supplementaryViewType.self,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: supplementaryViewType.reuseIdentifier
        )
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView> (
        _ viewType: T.Type = T.self,
        ofKind elementKind: String,
        for indexPath: IndexPath
    ) -> T {
        let view = self.dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: viewType.reuseIdentifier,
            for: indexPath
        )
        
        guard let view = view as? T else {
            fatalError("Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier)")
        }
        return view
    }
}
