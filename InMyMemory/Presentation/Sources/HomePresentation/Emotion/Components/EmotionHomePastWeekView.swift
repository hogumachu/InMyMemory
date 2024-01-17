//
//  EmotionHomePastWeekView.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import BasePresentation
import DesignKit
import SnapKit
import Then

struct EmotionHomePastWeekViewModel {
    let items: [EmotionHomePastWeekContentViewModel]
}

final class EmotionHomePastWeekView: BaseView {
    
    private let titleView = HomeTitleView()
    private let stackView = UIStackView()
    
    func setup(model: EmotionHomePastWeekViewModel) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        model.items.forEach { item in
            let view = EmotionHomePastWeekContentView()
            view.setup(model: item)
            stackView.addArrangedSubview(view)
        }
    }
    
    override func setupLayout() {
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        titleView.do {
            $0.title = "최근 7일간의 감정"
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = 10
        }
    }
    
}
