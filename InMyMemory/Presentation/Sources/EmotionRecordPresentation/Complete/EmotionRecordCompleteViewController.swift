//
//  EmotionRecordCompleteViewController.swift
//
//
//  Created by 홍성준 on 1/2/24.
//

import UIKit
import CoreKit
import BasePresentation
import DesignKit
import RxSwift
import ReactorKit
import Then
import SnapKit

final class EmotionRecordCompleteViewController: BaseViewController<EmotionRecordCompleteReactor> {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let completeButton = ActionButton()
    
    override func setupLayout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().offset(-20)
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(completeButton)
        completeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.height.equalTo(50)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        titleLabel.do {
            $0.text = "저장되었어요"
            $0.textColor = .orange1
            $0.textAlignment = .center
            $0.font = .gmarketSans(type: .medium, size: 27)
        }
        
        subtitleLabel.do {
            $0.text = "나의 감정이 더욱 풍부해졌어요"
            $0.textColor = .orange1
            $0.textAlignment = .center
            $0.font = .gmarketSans(type: .light, size: 21)
        }
        
        completeButton.do {
            $0.style = .normal
            $0.layer.cornerRadius = 25
            $0.setTitle("완료", for: .normal)
        }
    }
    
    override func bind(reactor: EmotionRecordCompleteReactor) {
        completeButton.rx.tap
            .map { Reactor.Action.completeDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
}
