//
//  EmotionRecordNoteViewController.swift
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

final class EmotionRecordNoteViewController: BaseViewController<EmotionRecordNoteReactor> {
    
    private let navigationView = NavigationView()
    private let titleLabel = UILabel()
    private let noteView = UITextView()
    private let nextButton = ActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTraitChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noteView.becomeFirstResponder()
    }
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-10)
            make.height.equalTo(50)
        }
        
        view.addSubview(noteView)
        noteView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(nextButton.snp.top).offset(-15)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .background
        
        navigationView.do {
            $0.backgroundColor = .background
            $0.setup(model: .init(leftButtonType: .back, rightButtonTypes: []))
        }
        
        titleLabel.do {
            $0.textAlignment = .center
        }
        
        noteView.do {
            $0.font = .gmarketSans(type: .light, size: 17)
            $0.textColor = .orange1
            $0.backgroundColor = .background
            $0.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
            $0.textContainerInset = .init(top: 0, left: 20, bottom: 0, right: 20)
            $0.showsVerticalScrollIndicator = false
            $0.layer.cornerRadius = 16
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.orange1.cgColor
        }
        
        nextButton.do {
            $0.style = .normal
            $0.setTitle("다음", for: .normal)
            $0.layer.cornerRadius = 25
        }
    }
    
    override func bind(reactor: EmotionRecordNoteReactor) {
        navigationView.rx.leftButtonDidTap
            .map { Reactor.Action.closeDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        noteView.rx.text
            .map { Reactor.Action.textDidUpdated($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.isEnabled)
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.emotionType)
            .bind(to: emotionTypeBinder)
            .disposed(by: disposeBag)
    }
    
    private func registerTraitChanges() {
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, previousTraitCollection: UITraitCollection) in
            self.noteView.layer.borderColor = UIColor.orange1.cgColor
        }
    }
    
    private var emotionTypeBinder: Binder<EmotionType> {
        return Binder(self) { this, type in
            switch type {
            case .good:
                this.titleLabel.attributedText = NSMutableAttributedString(string: "왜 좋은 기분이셨나요?")
                    .font(.gmarketSans(type: .light, size: 21))
                    .font(.gmarketSans(type: .medium, size: 21), text: "좋은 기분")
                    .foregroundColor(.orange1)
                    .foregroundColor(.blue1, text: "좋은 기분")
                
            case .soso:
                this.titleLabel.attributedText = NSMutableAttributedString(string: "왜 그냥 그런 기분이셨나요?")
                    .font(.gmarketSans(type: .light, size: 21))
                    .font(.gmarketSans(type: .medium, size: 21), text: "그냥 그런 기분")
                    .foregroundColor(.orange1)
                    .foregroundColor(.yellow1, text: "그냥 그런 기분")
                
            case .bad:
                this.titleLabel.attributedText = NSMutableAttributedString(string: "왜 나쁜 기분이셨나요?")
                    .font(.gmarketSans(type: .light, size: 21))
                    .font(.gmarketSans(type: .medium, size: 21), text: "나쁜 기분")
                    .foregroundColor(.orange1)
                    .foregroundColor(.red1, text: "나쁜 기분")
            }
        }
    }
    
}
