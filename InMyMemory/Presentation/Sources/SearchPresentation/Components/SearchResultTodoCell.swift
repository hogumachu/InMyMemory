//
//  SearchResultTodoCell.swift
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

struct SearchResultTodoCellModel {
    let id: UUID
    let note: String
    let isCompleted: Bool
    let date: String
}

final class SearchResultTodoCell: BaseCollectionViewCell {
    
    private let noteLabel = UILabel()
    private let dateLabel = UILabel()
    private let checkImageView = UIImageView()
    
    func setup(model: SearchResultTodoCellModel) {
        noteLabel.text = model.note
        dateLabel.text = model.date
        checkImageView.image = model.isCompleted ? .checkCircle.withRenderingMode(.alwaysTemplate) : .circle.withRenderingMode(.alwaysTemplate)
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        layer.borderColor = UIColor.orange1.cgColor
    }
    
    override func setupLayout() {
        contentView.addSubview(checkImageView)
        checkImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(noteLabel)
        noteLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(checkImageView.snp.leading).offset(-10)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(noteLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-15)
            make.trailing.equalTo(checkImageView.snp.leading).offset(-10)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .background
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.orange1.cgColor
        
        noteLabel.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
        
        dateLabel.do {
            $0.textColor = .orange2
            $0.font = .gmarketSans(type: .light, size: 13)
        }
        
        checkImageView.do {
            $0.image = .circle.withRenderingMode(.alwaysTemplate)
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .orange1
        }
    }
    
}
