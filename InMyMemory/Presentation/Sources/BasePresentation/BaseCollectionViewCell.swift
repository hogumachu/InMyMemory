//
//  BaseCollectionViewCell.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupAttributes()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupAttributes()
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
    
    open func setupLayout() {}
    open func setupAttributes() {}
    open func clear() {}
    
}
