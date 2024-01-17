//
//  TodoTargetDateViewController.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import UIKit
import CoreKit
import Entities
import BasePresentation
import DesignKit
import RxSwift
import RxDataSources
import ReactorKit
import Then
import SnapKit

final class TodoTargetDateViewController: BaseViewController<TodoTargetDateReactor> {
    
    private let navigationView = NavigationView()
    private let titleLabel = UILabel()
    private let calendarViewController = CalendarViewController()
    private let createButton = ActionButton()
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addChild(calendarViewController)
        view.addSubview(calendarViewController.view)
        calendarViewController.view.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        navigationView.do {
            $0.backgroundColor = .background
            $0.setup(model: .init(leftButtonType: .back, rightButtonTypes: []))
        }
        
        titleLabel.do {
            $0.text = "목표 날짜를 선택해주세요"
            $0.textColor = .orange1
            $0.textAlignment = .center
            $0.font = .gmarketSans(type: .light, size: 21)
        }
        
        createButton.do {
            $0.style = .normal
            $0.setTitle("저장하기", for: .normal)
            $0.layer.cornerRadius = 25
        }
    }
    
    override func bind(reactor: TodoTargetDateReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: Reactor) {
        rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        navigationView.rx.leftButtonDidTap
            .map { Reactor.Action.closeDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        calendarViewController.rx.monthLeftButtonDidTap
            .map { Reactor.Action.monthLeftDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        calendarViewController.rx.monthRightButtonDidTap
            .map { Reactor.Action.monthRightDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        calendarViewController.rx.dayDidTap
            .map { Reactor.Action.dayDidTap($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        createButton.rx.tap
            .map { Reactor.Action.createDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: Reactor) {
        reactor.state.map(\.monthTitle)
            .bind(to: calendarViewController.rx.monthTitle)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap(\.calendarViewModel)
            .bind(to: calendarViewController.rx.calendarViewModel)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.selectDay != nil }
            .bind(to: createButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
}
