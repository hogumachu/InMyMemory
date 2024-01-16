//
//  SearchResultEmotionCell.swift
//
//
//  Created by 홍성준 on 1/15/24.
//

import UIKit
import Entities
import CoreKit
import DesignKit
import BasePresentation
import SnapKit
import Then

struct SearchResultEmotionCellModel {
    let id: UUID
    let type: EmotionType
    let note: String
    let date: String
}

final class SearchResultEmotionCell: BaseCollectionViewCell {
    
    private let emotionView = UIView()
    private let noteLabel = UILabel()
    private let dateLabel = UILabel()
    
    func setup(model: SearchResultEmotionCellModel) {
        noteLabel.text = model.note
        dateLabel.text = model.date
        
        switch model.type {
        case .good:
            emotionView.backgroundColor = .blue1
            
        case .soso:
            emotionView.backgroundColor = .yellow1
            
        case .bad:
            emotionView.backgroundColor = .red1
        }
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        layer.borderColor = UIColor.orange1.cgColor
    }
    
    override func setupLayout() {
        contentView.addSubview(emotionView)
        emotionView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.size.equalTo(15)
        }
        
        contentView.addSubview(noteLabel)
        noteLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(emotionView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(noteLabel.snp.bottom).offset(3)
            make.leading.equalTo(emotionView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .background
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.orange1.cgColor
        
        emotionView.do {
            $0.layer.cornerRadius = 15 / 2
        }
        
        noteLabel.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
        
        dateLabel.do {
            $0.textColor = .orange2
            $0.font = .gmarketSans(type: .light, size: 13)
        }
    }
    
}
