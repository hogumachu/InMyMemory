//
//  EmotionHomeGraphInformationView.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import UIKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import RxRelay
import SnapKit
import Then

final class EmotionHomeGraphInformationView: EventThroughView {
    
    private var isAnimating = false
    private let contentView = EmotionHomeGraphInformationContentView()
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
    
    func showWithAnimation() {
        guard isAnimating == false else { return }
        isAnimating = true
        isThroughable = false
        contentView.transform = CGAffineTransform(translationX: 0, y: 20)
        
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.contentView.transform = .identity
                self.backgroundColor = .black.withAlphaComponent(0.8)
                self.contentView.alpha = 1.0
            },
            completion: { _ in
                self.isAnimating = false
            }
        )
    }
    
    private func hideWithAnimation() {
        guard isAnimating == false else { return }
        isAnimating = true
        isThroughable = true
        contentView.transform = .identity
        
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: 20)
                self.backgroundColor = .clear
                self.contentView.alpha = 0.0
            },
            completion: { _ in
                self.isAnimating = false
            }
        )
    }
    
    private func setupLayout() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupAttributes() {
        backgroundColor = .clear
        isThroughable = true
        
        contentView.do {
            $0.alpha = 0.0
        }
    }
    
    private func bind() {
        rx.recognizedTap
            .bind(to: backgroundBinder)
            .disposed(by: disposeBag)
        
        contentView.rx.closeTap
            .bind(to: closeBinder)
            .disposed(by: disposeBag)
        
    }
    
    private var backgroundBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.hideWithAnimation()
        }
    }
    
    private var closeBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.hideWithAnimation()
        }
    }
    
}
