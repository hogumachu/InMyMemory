//
//  EmotionHomeGraphBarView.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import UIKit
import BasePresentation
import DesignKit
import SnapKit
import Then

struct EmotionHomeGraphBarViewModel {
    let rate: CGFloat // -1.0 ~ 1.0
    let date: String
}

final class EmotionHomeGraphBarView: BaseView {
    
    static let barHeight: CGFloat = 70
    
    private let upperContainerView = UIView()
    private let upperBar = UIView()
    private var upperBarHeightConstraint: Constraint?
    
    private let lowerContainerView = UIView()
    private let lowerBar = UIView()
    private var lowerBarHeightConstraint: Constraint?
    
    private let dateLabel = UILabel()
    
    func setup(model: EmotionHomeGraphBarViewModel) {
        dateLabel.text = model.date
        
         if model.rate > 0.0 {
             upperBarHeightConstraint?.update(offset: EmotionHomeGraphBarView.barHeight * model.rate)
             lowerBarHeightConstraint?.update(offset: 0)
        } else {
            upperBarHeightConstraint?.update(offset: 0)
            lowerBarHeightConstraint?.update(offset: EmotionHomeGraphBarView.barHeight * -model.rate)
        }
    }
    
    override func setupLayout() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.width.equalTo(30)
        }
        
        addSubview(upperContainerView)
        upperContainerView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 10, height: EmotionHomeGraphBarView.barHeight))
        }
        
        upperContainerView.addSubview(upperBar)
        upperBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            upperBarHeightConstraint = make.height.equalTo(0).constraint
        }
        
        addSubview(lowerContainerView)
        lowerContainerView.snp.makeConstraints { make in
            make.top.equalTo(upperContainerView.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(dateLabel.snp.top).offset(-10)
            make.size.equalTo(CGSize(width: 10, height: EmotionHomeGraphBarView.barHeight))
        }
        
        lowerContainerView.addSubview(lowerBar)
        lowerBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            lowerBarHeightConstraint = make.height.equalTo(0).constraint
        }
    }
    
    override func setupAttributes() {
        upperContainerView.do {
            $0.backgroundColor = .background
        }
        
        upperBar.do {
            $0.backgroundColor = .orange1
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
            $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
        
        lowerContainerView.do {
            $0.backgroundColor = .background
        }
        
        lowerBar.do {
            $0.backgroundColor = .orange1
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
            $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        dateLabel.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 11)
            $0.textAlignment = .center
        }
    }
    
}
