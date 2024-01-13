//
//  RecordViewController.swift
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

final class RecordViewController: BaseViewController<RecordReactor> {
    
    private let navigationView = NavigationView()
    private let titleLabel = UILabel()
    private let memoryRecordButton = ActionButton()
    private let emotionRecordButton = ActionButton()
    private let todoRecordButton = ActionButton()
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        let buttonSize: CGSize = .init(width: 180, height: 40)
        view.addSubview(emotionRecordButton)
        emotionRecordButton.snp.makeConstraints { make in
            make.size.equalTo(buttonSize)
            make.center.equalToSuperview()
        }
        
        view.addSubview(memoryRecordButton)
        memoryRecordButton.snp.makeConstraints { make in
            make.size.equalTo(buttonSize)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(emotionRecordButton.snp.top).offset(-20)
        }
        
        view.addSubview(todoRecordButton)
        todoRecordButton.snp.makeConstraints { make in
            make.size.equalTo(buttonSize)
            make.centerX.equalToSuperview()
            make.top.equalTo(emotionRecordButton.snp.bottom).offset(20)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(memoryRecordButton.snp.top).offset(-60)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        navigationView.do {
            $0.backgroundColor = .background
            $0.setup(model: .init(leftButtonType: .close, rightButtonTypes: []))
        }
        
        titleLabel.do {
            $0.text = "어떤 것을 기록하나요?"
            $0.textColor = .orange1
            $0.textAlignment = .center
            $0.font = .gmarketSans(type: .light, size: 21)
            $0.numberOfLines = 0
        }
        
        memoryRecordButton.do {
            $0.style = .border
            $0.setTitle("기억 기록하기", for: .normal)
            $0.layer.cornerRadius = 20
        }
        
        emotionRecordButton.do {
            $0.style = .border
            $0.setTitle("감정 기록하기", for: .normal)
            $0.layer.cornerRadius = 20
        }
        
        todoRecordButton.do {
            $0.style = .border
            $0.setTitle("할일 기록하기", for: .normal)
            $0.layer.cornerRadius = 20
        }
    }
    
    override func bind(reactor: RecordReactor) {
        navigationView.rx.leftButtonDidTap
            .map { Reactor.Action.closeDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        memoryRecordButton.rx.tap
            .map { Reactor.Action.memoryRecordDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        emotionRecordButton.rx.tap
            .map { Reactor.Action.emotionRecordDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
}
