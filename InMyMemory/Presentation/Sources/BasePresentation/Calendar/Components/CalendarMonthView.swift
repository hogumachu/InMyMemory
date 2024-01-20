//
//  CalendarMonthView.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit
import DesignKit
import RxSwift
import RxCocoa
import SnapKit
import Then

public final class CalendarMonthView: BaseView {
    
    typealias Identifiers = BasePresentationAccessibilityIdentifiers.Calendar.MonthView
    
    fileprivate let titleLabel = UILabel()
    fileprivate let leftButton = UIButton()
    fileprivate let rightButton = UIButton()
    
    public override func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(130)
        }
        
        addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(titleLabel.snp.leading).offset(-5)
        }
        
        addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
        }
    }
    
    public override func setupAttributes() {
        backgroundColor = .background
        
        titleLabel.do {
            $0.textColor = .orange1
            $0.textAlignment = .center
            $0.font = .gmarketSans(type: .light, size: 21)
        }
        
        leftButton.do {
            $0.accessibilityIdentifier = Identifiers.leftButton
            $0.setImage(.chevronLeft.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .orange1
        }
        
        rightButton.do {
            $0.accessibilityIdentifier = Identifiers.rightButton
            $0.setImage(.chevronRight.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .orange1
        }
    }
    
}

public extension Reactive where Base: CalendarMonthView {
    
    var title: Binder<String?> {
        return base.titleLabel.rx.text
    }
    
    var leftButtonDidTap: ControlEvent<Void> {
        let source = base.leftButton.rx.tap
        return ControlEvent(events: source)
    }
    
    var rightButtonDidTap: ControlEvent<Void> {
        let source = base.rightButton.rx.tap
        return ControlEvent(events: source)
    }
    
}
