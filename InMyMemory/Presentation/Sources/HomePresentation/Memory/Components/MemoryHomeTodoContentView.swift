//
//  MemoryHomeTodoContentView.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import BasePresentation
import DesignKit
import SnapKit
import Then

struct MemoryHomeTodoContentViewModel {
    let id: UUID
    let todo: String
    let isChecked: Bool
    let date: Date
}

final class MemoryHomeTodoContentView: BaseView {
    
    private let totoLabel = UILabel()
    private let checkImageView = UIImageView()
    
    func setup(model: MemoryHomeTodoContentViewModel) {
        let attributedString = NSMutableAttributedString(string: model.todo)
            .foregroundColor(model.isChecked ? .orange2 : .orange1)
            .underlineColor(model.isChecked ? .orange2 : .orange1)
        
        totoLabel.attributedText = model.isChecked ? attributedString.singleStrikethrough() : attributedString
        checkImageView.image = model.isChecked ? .checkCircle.withRenderingMode(.alwaysTemplate) : .circle.withRenderingMode(.alwaysTemplate)
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        layer.borderColor = UIColor.orange1.cgColor
    }
    
    override func setupLayout() {
        addSubview(checkImageView)
        checkImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        
        addSubview(totoLabel)
        totoLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(checkImageView.snp.leading).offset(-10)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .background
        layer.borderWidth = 1
        layer.borderColor = UIColor.orange1.cgColor
        
        totoLabel.do {
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
