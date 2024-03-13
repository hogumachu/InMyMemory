//
//  EmotionDetailViewController.swift
//
//
//  Created by 홍성준 on 3/13/24.
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

struct EmotionDetailViewModel {
    let date: String
    let note: String
    let emotionType: EmotionType
}

final class EmotionDetailViewController: BaseViewController<EmotionDetailReactor> {
    
    private let navigationView = NavigationView()
    private let scrollView = UIScrollView()
    private let dateLabel = UILabel()
    private let emotionLabel = UILabel()
    private let separator = UIView()
    private let noteLabel = UILabel()
    private let buttonStackView = UIStackView()
    private let removeButton = ActionButton()
    private let editButton = ActionButton()
    private let loadingView = LoadingView()
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        buttonStackView.addArrangedSubview(removeButton)
        buttonStackView.addArrangedSubview(editButton)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(buttonStackView.snp.top)
        }
        
        scrollView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalTo(view).inset(20)
        }
        
        scrollView.addSubview(emotionLabel)
        emotionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view).inset(20)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        scrollView.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view).inset(20)
            make.height.equalTo(1)
        }
        
        scrollView.addSubview(noteLabel)
        noteLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view).inset(20)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        navigationView.do {
            $0.backgroundColor = .background
            $0.setup(model: .init(leftButtonType: .back, rightButtonTypes: []))
        }
        
        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
        
        dateLabel.do {
            $0.numberOfLines = 0
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
        
        emotionLabel.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
        
        noteLabel.do {
            $0.numberOfLines = 0
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
        }
        
        separator.do {
            $0.backgroundColor = .orange1
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        removeButton.do {
            $0.style = .border
            $0.setTitle("제거하기", for: .normal)
            $0.layer.cornerRadius = 25
        }
        
        editButton.do {
            $0.style = .normal
            $0.setTitle("수정하기", for: .normal)
            $0.layer.cornerRadius = 25
        }
    }
    
    override func bind(reactor: EmotionDetailReactor) {
        bindState(reactor)
        bindAction(reactor)
    }
    
    private func bindState(_ reactor: Reactor) {
        reactor.state.compactMap(\.viewModel)
            .map(\.date)
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap(\.viewModel)
            .map(\.note)
            .bind(to: noteLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap(\.viewModel)
            .map(\.emotionType)
            .bind(to: emotionTypeBinder)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.isLoading)
            .bind(to: loadingView.isLoading)
            .disposed(by: disposeBag)
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
    }
    
    private var emotionTypeBinder: Binder<EmotionType> {
        return Binder(self) { this, type in
            switch type {
            case .good:
                this.emotionLabel.attributedText = NSMutableAttributedString(string: "좋은 기분이에요")
                    .font(.gmarketSans(type: .light, size: 17))
                    .font(.gmarketSans(type: .medium, size: 17), text: "좋은 기분")
                    .foregroundColor(.orange1)
                    .foregroundColor(.blue1, text: "좋은 기분")
                
            case .soso:
                this.emotionLabel.attributedText = NSMutableAttributedString(string: "그냥 그런 기분이에요")
                    .font(.gmarketSans(type: .light, size: 17))
                    .font(.gmarketSans(type: .medium, size: 17), text: "그냥 그런 기분")
                    .foregroundColor(.orange1)
                    .foregroundColor(.yellow1, text: "그냥 그런 기분")
                
            case .bad:
                this.emotionLabel.attributedText = NSMutableAttributedString(string: "나쁜 기분이에요")
                    .font(.gmarketSans(type: .light, size: 17))
                    .font(.gmarketSans(type: .medium, size: 17), text: "나쁜 기분")
                    .foregroundColor(.orange1)
                    .foregroundColor(.red1, text: "나쁜 기분")
            }
        }
    }
    
}
