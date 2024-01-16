//
//  SearchInputView.swift
//
//
//  Created by 홍성준 on 1/15/24.
//

import UIKit
import CoreKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class SearchInputView: BaseView {
    
    private let imageView = UIImageView()
    fileprivate let textField = UITextField()
    
    override func setupLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func setupAttributes() {
        self.do {
            $0.backgroundColor = .background
            $0.layer.cornerRadius = 16
            $0.layer.borderColor = UIColor.orange1.cgColor
            $0.layer.borderWidth = 1
        }
        
        imageView.do {
            $0.image = .search.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .orange1
        }
        
        textField.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 17)
            $0.backgroundColor = .background
            $0.returnKeyType = .search
            $0.attributedPlaceholder = NSMutableAttributedString(string: "기억, 감정, 할일 등")
                .font(.gmarketSans(type: .light, size: 17))
                .foregroundColor(.orange2)
        }
    }
    
}

extension Reactive where Base: SearchInputView {
    
    var text: ControlEvent<String?> {
        let source = base.textField.rx.text
        return ControlEvent(events: source)
    }
    
    var searchDidTap: ControlEvent<String> {
        let source = base.textField.rx.controlEvent(.editingDidEndOnExit)
            .map { base.textField.text ?? "" }
        return ControlEvent(events: source)
    }
    
}
