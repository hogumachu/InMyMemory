//
//  CalendarMemoryListCell.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit
import CoreKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import Then
import SnapKit

struct CalendarMemoryListCellModel {
    let note: String
    let imageData: Data?
}

final class CalendarMemoryListCell: BaseCollectionViewCell {
    
    private let imageView = UIImageView()
    private let noteLabel = UILabel()
    
    func setup(model: CalendarMemoryListCellModel) {
        noteLabel.text = model.note
        imageView.image = model.imageData.flatMap { UIImage(data: $0) }
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        imageView.layer.borderColor = UIColor.orange1.cgColor
    }
    
    override func setupLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.leading.bottom.equalToSuperview()
        }
        
        contentView.addSubview(noteLabel)
        noteLabel.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(10)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .background
        
        imageView.do {
            $0.backgroundColor = .background
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.orange1.cgColor
            $0.layer.cornerRadius = 16
            $0.clipsToBounds = true
        }
        
        noteLabel.do {
            $0.textColor = .orange1
            $0.numberOfLines = 3
            $0.font = .gmarketSans(type: .light, size: 17)
        }
    }
    
}
