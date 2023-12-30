//
//  MemoryHomeTitleView.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import BasePresentation
import DesignKit
import SnapKit
import Then

final class MemoryHomeTitleView: BaseView {
    
    var title: String? = nil {
        didSet { titleLabel.text = title }
    }
    
    private let titleLabel = UILabel()
    
    override func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        titleLabel.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .medium, size: 21)
            $0.numberOfLines = 0
        }
    }
    
}
