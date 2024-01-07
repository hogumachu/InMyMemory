//
//  UICollectionView+.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit

extension UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

public extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(cell, forCellWithReuseIdentifier: cell.identifier)
    }
    
    func dequeue<T: UICollectionViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? T else {
            fatalError("\(cell)을 등록하지 않았습니다")
        }
        return cell
    }
    
    func registerHeader<T: UICollectionReusableView>(_ view: T.Type) {
        self.register(view, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: view.identifier)
    }
    
    func dequeueHeader<T: UICollectionReusableView>(_ view: T.Type, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: view.identifier,
            for: indexPath
        ) as? T else {
            fatalError("\(view)을 등록하지 않았습니다")
        }
        return view
    }
    
}
