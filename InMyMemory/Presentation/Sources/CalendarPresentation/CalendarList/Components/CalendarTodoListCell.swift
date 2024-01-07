//
//  CalendarTodoListCell.swift
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

struct CalendarTodoListCellModel {
    let note: String
    let isCompleted: Bool
}

final class CalendarTodoListCell: BaseCollectionViewCell {
    
    private let checkImageView = UIImageView()
    private let noteLabel = UILabel()
    
    func setup(model: CalendarTodoListCellModel) {
        noteLabel.text = model.note
        checkImageView.image = model.isCompleted ? .checkCircle.withRenderingMode(.alwaysTemplate) : .circle.withRenderingMode(.alwaysTemplate)
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        layer.borderColor = UIColor.orange1.cgColor
    }
    
    override func setupLayout() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        contentView.addSubview(checkImageView)
        checkImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(20)
        }
        
        contentView.addSubview(noteLabel)
        noteLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(checkImageView.snp.leading).offset(-15)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .background
        layer.cornerRadius = 40 / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.orange1.cgColor
        
        noteLabel.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
        
        checkImageView.do {
            $0.image = .circle.withRenderingMode(.alwaysTemplate)
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .orange1
        }
    }
    
}
