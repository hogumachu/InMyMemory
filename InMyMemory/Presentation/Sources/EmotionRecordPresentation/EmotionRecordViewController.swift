//
//  EmotionRecordViewController.swift
//
//
//  Created by 홍성준 on 1/2/24.
//

import UIKit
import CoreKit
import Entities
import BasePresentation
import DesignKit
import RxSwift
import ReactorKit
import Then
import SnapKit

final class EmotionRecordViewController: BaseViewController<EmotionRecordReactor> {
    
    private let navigationView = NavigationView()
    private let titleLabel = UILabel()
    private let goodButton = ActionButton()
    private let sosoButton = ActionButton()
    private let badButton = ActionButton()
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        let buttonSize: CGSize = .init(width: 180, height: 40)
        view.addSubview(sosoButton)
        sosoButton.snp.makeConstraints { make in
            make.size.equalTo(buttonSize)
            make.center.equalToSuperview()
        }
        
        view.addSubview(goodButton)
        goodButton.snp.makeConstraints { make in
            make.size.equalTo(buttonSize)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(sosoButton.snp.top).offset(-20)
        }
        
        view.addSubview(badButton)
        badButton.snp.makeConstraints { make in
            make.size.equalTo(buttonSize)
            make.centerX.equalToSuperview()
            make.top.equalTo(sosoButton.snp.bottom).offset(20)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(goodButton.snp.top).offset(-60)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        navigationView.do {
            $0.backgroundColor = .background
            $0.setup(model: .init(leftButtonType: .back, rightButtonTypes: []))
        }
        
        titleLabel.do {
            $0.text = "기분이 어떠신가요?"
            $0.textColor = .orange1
            $0.textAlignment = .center
            $0.font = .gmarketSans(type: .light, size: 21)
            $0.numberOfLines = 0
        }
        
        goodButton.do {
            $0.style = .border
            $0.setTitle("좋아요", for: .normal)
            $0.layer.cornerRadius = 20
        }
        
        sosoButton.do {
            $0.style = .border
            $0.setTitle("그냥 그래요", for: .normal)
            $0.layer.cornerRadius = 20
        }
        
        badButton.do {
            $0.style = .border
            $0.setTitle("나빠요", for: .normal)
            $0.layer.cornerRadius = 20
        }
    }
    
    override func bind(reactor: EmotionRecordReactor) {
        navigationView.rx.leftButtonDidTap
            .map { Reactor.Action.closeDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        goodButton.rx.tap
            .map { Reactor.Action.buttonDidTap(.good) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        sosoButton.rx.tap
            .map { Reactor.Action.buttonDidTap(.soso) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        badButton.rx.tap
            .map { Reactor.Action.buttonDidTap(.bad) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
}
