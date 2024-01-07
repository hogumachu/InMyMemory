//
//  CalendarDayView.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit
import Entities
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import SnapKit
import Then

struct CalendarDayViewModel {
    let day: Int
    let isToday: Bool
    let isSelected: Bool
    let isValid: Bool
    let emotionType: EmotionType?
}

final class CalendarDayView: BaseView {
    
    private let containerView = UIView()
    private let dayLabel = UILabel()
    private let emotionView = UIView()
    
    func setup(model: CalendarDayViewModel) {
        guard model.isValid else {
            clear()
            return
        }
        dayLabel.text = "\(model.day)"
        
        if model.isToday {
            containerView.backgroundColor = model.isSelected ? .reverseBackground : .background
            dayLabel.textColor = model.isSelected ? .background : .reverseBackground
        } else {
            containerView.backgroundColor = model.isSelected ? .orange1 : .background
            dayLabel.textColor = model.isSelected ? .background : .orange1
        }
        
        let emotionBackgroundColor: UIColor = {
            switch model.emotionType {
            case .good: .blue1
            case .soso: .yellow1
            case .bad: .red1
            default: .background
            }
        }()
        emotionView.backgroundColor = emotionBackgroundColor
    }
    
    func clear() {
        dayLabel.text = nil
        containerView.backgroundColor = .background
        emotionView.backgroundColor = .background
    }
    
    override func setupLayout() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(30)
        }
        
        containerView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addSubview(emotionView)
        emotionView.snp.makeConstraints { make in
            make.size.equalTo(5)
            make.centerX.equalToSuperview()
            make.top.equalTo(containerView.snp.bottom).offset(2)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    override func setupAttributes() {
        containerView.do {
            $0.backgroundColor = .background
            $0.layer.cornerRadius = 30 / 2
        }
        
        dayLabel.do {
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .medium, size: 17)
            $0.textAlignment = .center
        }
        
        emotionView.do {
            $0.backgroundColor = .background
            $0.layer.cornerRadius = 5 / 2
        }
    }
    
}
