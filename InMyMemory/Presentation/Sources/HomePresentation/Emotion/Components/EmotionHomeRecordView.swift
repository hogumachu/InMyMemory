//
//  EmotionHomeRecordView.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import BasePresentation
import DesignKit
import SnapKit
import Then

final class EmotionHomeRecordView: BaseView {
    
    private let titleView = HomeTitleView()
    private let recordButton = ActionButton()
    
    override func setupLayout() {
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        addSubview(recordButton)
        recordButton.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 40))
        }
    }
    
    override func setupAttributes() {
        titleView.do {
            $0.title = "지금 기분이 어떠신가요?"
        }
        
        recordButton.do {
            $0.style = .border
            $0.setTitle("기록하기", for: .normal)
            $0.layer.cornerRadius = 20
        }
    }
    
}
