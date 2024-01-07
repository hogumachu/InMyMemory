//
//  CalendarDayOfWeekView.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit
import BasePresentation
import DesignKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class CalendarDayOfWeekView: BaseView {
    
    private let stackView = UIStackView()
    
    override func setupLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        ["S", "M", "T", "W", "T", "F", "S"].forEach { day in
            let label = makeLabel(text: day)
            stackView.addArrangedSubview(label)
        }
    }
    
    override func setupAttributes() {
        stackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fillEqually
        }
    }
    
    private func makeLabel(text: String) -> UILabel {
        return UILabel().with {
            $0.text = text
            $0.textColor = .orange1
            $0.font = .gmarketSans(type: .light, size: 14)
            $0.textAlignment = .center
        }
    }
    
}
