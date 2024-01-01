//
//  EmotionHomeGraphInformationContentView.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import UIKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class EmotionHomeGraphInformationContentView: BaseView {
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let emotionStackView = UIStackView()
    fileprivate let closeButton = ActionButton()
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        layer.borderColor = UIColor.orange1.cgColor
    }
    
    override func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(emotionStackView)
        emotionStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        makeEmotionContentViews().forEach { view in
            emotionStackView.addArrangedSubview(view)
        }
        
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(emotionStackView.snp.bottom).offset(20)
            make.trailing.bottom.equalToSuperview().inset(20)
            make.size.equalTo(CGSize(width: 130, height: 40))
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .background
        layer.borderWidth = 1
        layer.borderColor = UIColor.orange1.cgColor
        layer.cornerRadius = 16
        
        titleLabel.do {
            $0.text = "감정 그래프"
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .medium, size: 21)
        }
        
        descriptionLabel.do {
            $0.text = "작성한 감정을 모두 더한 값이에요"
            $0.textColor = .orange1
            $0.numberOfLines = 0
            $0.font = .gmarketSans(type: .light, size: 17)
        }
        
        emotionStackView.do {
            $0.axis = .horizontal
            $0.spacing = 15
            $0.alignment = .fill
            $0.distribution = .equalSpacing
        }
        
        closeButton.do {
            $0.style = .normal
            $0.setTitle("닫기", for: .normal)
            $0.layer.cornerRadius = 20
        }
    }
    
    private func makeEmotionContentViews() -> [EmotionHomeGraphInformationEmotionContentView] {
        return EmotionHomeGraphInformationEmotionContentView.EmotionStyle.allCases.map { style in
            return .init().with { $0.setupStyle(style) }
        }
    }
    
}

extension Reactive where Base: EmotionHomeGraphInformationContentView {
    
    var closeTap: ControlEvent<Void> {
        let source = base.closeButton.rx.tap
        return ControlEvent(events: source)
    }
    
}

private final class EmotionHomeGraphInformationEmotionContentView: BaseView {
    
    enum EmotionStyle: CaseIterable {
        case good
        case soso
        case bad
        
        var color: UIColor {
            switch self {
            case .good: return .blue1
            case .soso: return .yellow1
            case .bad: return .red1
            }
        }
        
        var scoreText: String {
            switch self {
            case .good: return "+1"
            case .soso: return "0"
            case .bad: return "-1"
            }
        }
        
        var title: String {
            switch self {
            case .good: return "좋아요"
            case .soso: return "그냥 그래요"
            case .bad: return "나빠요"
            }
        }
    }
    
    private let scoreLabel = UILabel()
    private let titleLabel = UILabel()
    
    func setupStyle(_ style: EmotionStyle) {
        scoreLabel.textColor = style.color
        scoreLabel.text = style.scoreText
        titleLabel.textColor = style.color
        titleLabel.text = style.title
    }
    
    override func setupLayout() {
        addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(scoreLabel.snp.trailing).offset(3)
            make.top.bottom.trailing.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        scoreLabel.do {
            $0.font = .gmarketSans(type: .bold, size: 17)
        }
        
        titleLabel.do {
            $0.font = .gmarketSans(type: .light, size: 17)
        }
    }
    
}
