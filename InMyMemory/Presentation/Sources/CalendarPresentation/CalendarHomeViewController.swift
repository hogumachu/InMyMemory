//
//  CalendarHomeViewController.swift
//  
//
//  Created by 홍성준 on 1/7/24.
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

final class CalendarHomeViewController: BaseViewController<CalendarHomeReactor> {
    
    typealias Identifiers = CalendarAccessibilityIdentifiers.Home
    
    private let navigationView = NavigationView()
    private let calendarViewController = CalendarViewController()
    private let calendarListViewController = CalendarListViewController()
    
    private let separator = UIView()
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        addChild(calendarViewController)
        view.addSubview(calendarViewController.view)
        calendarViewController.view.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(calendarViewController.view.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addChild(calendarListViewController)
        view.addSubview(calendarListViewController.view)
        calendarListViewController.view.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        navigationView.do {
            $0.backgroundColor = .background
            $0.accessibilityIdentifier = Identifiers.navigationView
            $0.setup(model: .init(
                leftButtonType: .back,
                rightButtonTypes: [.search, .plus]
            ))
        }
        
        separator.do {
            $0.backgroundColor = .orange1
        }
    }
    
    override func bind(reactor: CalendarHomeReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    override func refresh() {
        reactor?.action.onNext(.refresh)
    }
    
    private func bindAction(_ reactor: Reactor) {
        rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        navigationView.rx.leftButtonDidTap
            .map { Reactor.Action.closeDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        navigationView.rx.rightButtonDidTap
            .filter { $0 == .plus }
            .map { _ in Reactor.Action.addDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        navigationView.rx.rightButtonDidTap
            .filter { $0 == .search }
            .map { _ in Reactor.Action.searchDidTap }
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
    }
    
    private func bindState(_ reactor: Reactor) {
        reactor.state.map(\.monthTitle)
            .bind(to: calendarViewController.rx.monthTitle)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap(\.calendarViewModel)
            .bind(to: calendarViewController.rx.calendarViewModel)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.calendarListSections)
            .bind(to: calendarListViewController.rx.sections)
            .disposed(by: disposeBag)
    }
    
}
