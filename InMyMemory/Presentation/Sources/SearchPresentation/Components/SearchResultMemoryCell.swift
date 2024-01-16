//
//  SearchResultMemoryCell.swift
//  
//
//  Created by 홍성준 on 1/15/24.
//

import UIKit
import CoreKit
import DesignKit
import BasePresentation
import SnapKit
import Then

struct SearchResultMemoryCellModel {
    let id: UUID
    let note: String
    let imagteData: Data?
    let date: String
}

final class SearchResultMemoryCell: BaseCollectionViewCell {
    
    private let imageView = UIImageView()
    private let noteLabel = UILabel()
    private let dateLabel = UILabel()
    
    func setup(model: SearchResultMemoryCellModel) {
        noteLabel.text = model.note
        dateLabel.text = model.date
        imageView.image = model.imagteData.flatMap { .init(data: $0) }
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        layer.borderColor = UIColor.orange1.cgColor
        imageView.layer.borderColor = UIColor.orange1.cgColor
    }
    
    override func setupLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.size.equalTo(40)
        }
        
        contentView.addSubview(noteLabel)
        noteLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(noteLabel.snp.bottom).offset(3)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .background
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.orange1.cgColor
        
        imageView.do {
            $0.backgroundColor = .background
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.orange1.cgColor
            $0.layer.cornerRadius = 16
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        noteLabel.do {
            $0.textColor = .orange1
            $0.numberOfLines = 1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
        
        dateLabel.do {
            $0.textColor = .orange2
            $0.font = .gmarketSans(type: .light, size: 13)
        }
    }
    
}
