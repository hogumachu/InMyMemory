//
//  TodoRecordTodoCell.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import UIKit
import Entities
import CoreKit
import DesignKit
import BasePresentation
import SnapKit
import Then

final class TodoRecordTodoCell: BaseCollectionViewCell {
    
    private let textLabel = UILabel()
    
    func setup(todo: String) {
        textLabel.text = todo
    }
    
    override func setupLayout() {
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .background
        
        textLabel.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
    }
    
}
