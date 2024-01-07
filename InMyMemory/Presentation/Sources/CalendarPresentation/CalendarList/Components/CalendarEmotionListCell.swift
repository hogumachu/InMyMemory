//
//  CalendarEmotionListCell.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit
import Entities
import CoreKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import Then
import SnapKit

struct CalendarEmotionListCellModel {
    let type: EmotionType
    let note: String
}

final class CalendarEmotionListCell: BaseCollectionViewCell {
    
    private let emotionView = UIView()
    private let noteLabel = UILabel()
    
    func setup(model: CalendarEmotionListCellModel) {
        noteLabel.text = model.note
        
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
            make.top.leading.bottom.equalToSuperview().inset(20)
            make.size.equalTo(15)
        }
        
        contentView.addSubview(noteLabel)
        noteLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(emotionView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .background
        layer.cornerRadius = 55 / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.orange1.cgColor
        
        emotionView.do {
            $0.layer.cornerRadius = 15 / 2
        }
        
        noteLabel.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
    }
    
}
