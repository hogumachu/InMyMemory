//
//  TodoRecordInputView.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import UIKit
import CoreKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import RxRelay
import SnapKit
import Then

final class TodoRecordInputView: BaseView {
    
    private let containerView = UIView()
    fileprivate let textField = UITextField()
    fileprivate let xImageView = UIImageView()
    fileprivate let nextButton = ActionButton()
    fileprivate let returnRelay = PublishRelay<Void>()
    
    var isClearEnabled: Binder<Bool> {
        return Binder(self) { this, isClearEnabled in
            this.xImageView.isHidden = !isClearEnabled
        }
    }
    
    func clear() {
        textField.text = ""
        xImageView.isHidden = true
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    override func setupLayout() {
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(nextButton.snp.top).offset(-10)
        }
        
        containerView.addSubview(xImageView)
        xImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
        
        containerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().offset(-45)
            make.height.equalTo(25)
        }
    }
    
    override func setupAttributes() {
        containerView.do {
            $0.backgroundColor = .background
            $0.layer.cornerRadius = 16
            $0.layer.borderColor = UIColor.orange1.cgColor
            $0.layer.borderWidth = 1
        }
        
        textField.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
            $0.backgroundColor = .background
            $0.returnKeyType = .continue
            $0.attributedPlaceholder = NSMutableAttributedString(string: "할일을 작성해주세요")
                .font(.gmarketSans(type: .light, size: 17))
                .foregroundColor(.orange2)
            $0.delegate = self
        }
        
        xImageView.do {
            $0.image = .xmarkCircle.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .orange1
            $0.isHidden = true
        }
        
        nextButton.do {
            $0.style = .normal
            $0.setTitle("다음", for: .normal)
            $0.layer.cornerRadius = 25
        }
    }
    
}

extension Reactive where Base: TodoRecordInputView {
    
    var text: ControlEvent<String?> {
        let source = base.textField.rx.text
        return ControlEvent(events: source)
    }
    
    var returnDidTap: ControlEvent<String> {
        let source = base.returnRelay.asObservable()
            .compactMap { base.textField.text }
        return ControlEvent(events: source)
    }
    
    var removeDidTap: ControlEvent<Void> {
        let source = base.xImageView.rx.recognizedTap
        return ControlEvent(events: source)
    }
    
    var nextDidTap: ControlEvent<Void> {
        let source = base.nextButton.rx.tap
        return ControlEvent(events: source)
    }
    
}

extension TodoRecordInputView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnRelay.accept(())
        return false
    }
    
}
