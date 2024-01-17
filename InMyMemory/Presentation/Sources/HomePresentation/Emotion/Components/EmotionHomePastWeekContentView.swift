//
//  EmotionHomePastWeekContentView.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import BasePresentation
import DesignKit
import SnapKit
import Then

struct EmotionHomePastWeekContentViewModel {
    let score: Int
    let emotion: String
}

final class EmotionHomePastWeekContentView: BaseView {
    
    private let stackView = UIStackView()
    private let scoreLabel = UILabel()
    private let emotionLabel = UILabel()
    
    func setup(model: EmotionHomePastWeekContentViewModel) {
        scoreLabel.text = "+\(model.score)"
        emotionLabel.text = model.emotion
    }
    
    override func setupLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        stackView.addArrangedSubview(scoreLabel)
        stackView.addArrangedSubview(emotionLabel)
    }
    
    override func setupAttributes() {
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .leading
            $0.distribution = .equalSpacing
        }
        
        scoreLabel.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .bold, size: 17)
        }
        
        emotionLabel.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
    }
    
}
