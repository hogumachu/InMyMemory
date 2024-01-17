//
//  HomeSideView.swift
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

final class HomeSideView: EventThroughView {
    
    private var isAnimating = false
    private let sideButton = HomeSideButton()
    
    private let buttonStackView = UIStackView()
    
    fileprivate let calendarButton = ActionButton()
    fileprivate let recordButton = ActionButton()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupAttributes()
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupAttributes()
        bind()
    }
    
    private func showButtonsWithAnimation() {
        guard isAnimating == false else { return }
        isAnimating = true
        isThroughable = false
        buttonStackView.transform = CGAffineTransform(translationX: 0, y: 20)
        
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.buttonStackView.transform = .identity
                self.backgroundColor = .black.withAlphaComponent(0.8)
                self.buttonStackView.alpha = 1.0
                self.sideButton.updateStyle(style: .close)
            },
            completion: { _ in
                self.isAnimating = false
            }
        )
    }
    
    private func hideButtonsWithAnimation() {
        guard isAnimating == false else { return }
        isAnimating = true
        isThroughable = true
        buttonStackView.transform = .identity
        
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.buttonStackView.transform = CGAffineTransform(translationX: 0, y: 20)
                self.buttonStackView.alpha = 0.0
                self.backgroundColor = .clear
                self.sideButton.updateStyle(style: .menu)
            },
            completion: { _ in
                self.isAnimating = false
            }
        )
    }
    
    private func toggleMode() {
        if isThroughable {
            showButtonsWithAnimation()
        } else {
            hideButtonsWithAnimation()
        }
    }
    
    private func setupLayout() {
        addSubview(sideButton)
        sideButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.size.equalTo(60)
        }
        
        insertSubview(buttonStackView, belowSubview: sideButton)
        buttonStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(sideButton.snp.top).offset(-20)
        }
        
        buttonStackView.addArrangedSubview(calendarButton)
        calendarButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 145, height: 40))
        }
        
        buttonStackView.addArrangedSubview(recordButton)
        recordButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 120, height: 40))
        }
    }
    
    private func setupAttributes() {
        backgroundColor = .clear
        isThroughable = true
        
        sideButton.do {
            $0.tintColor = .background
            $0.updateStyle(style: .menu)
            $0.layer.cornerRadius = 30
        }
        
        buttonStackView.do {
            $0.axis = .vertical
            $0.spacing = 10
            $0.distribution = .fillEqually
            $0.alignment = .trailing
            $0.alpha = 0.0
        }
        
        calendarButton.do {
            $0.style = .border
            $0.setTitle("캘린더 보기", for: .normal)
            $0.layer.cornerRadius = 20
        }
        
        recordButton.do {
            $0.style = .border
            $0.setTitle("기록하기", for: .normal)
            $0.layer.cornerRadius = 20
        }
    }
    
    private func bind() {
        rx.recognizedTap
            .bind(to: backgroundBinder)
            .disposed(by: disposeBag)
        
        sideButton.rx.tap
            .bind(to: sideButtonBinder)
            .disposed(by: disposeBag)
    }
    
    private var backgroundBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.hideButtonsWithAnimation()
        }
    }
    
    private var sideButtonBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.toggleMode()
        }
    }
    
}

extension Reactive where Base: HomeSideView {
    
    var calendarDidTap: ControlEvent<Void> {
        let source = base.calendarButton.rx.tap
        return ControlEvent(events: source)
    }
    
    var recordDidTap: ControlEvent<Void> {
        let source = base.recordButton.rx.tap
        return ControlEvent(events: source)
    }
    
}
