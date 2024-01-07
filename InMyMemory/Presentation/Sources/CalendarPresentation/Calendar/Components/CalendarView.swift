//
//  CalendarView.swift
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

struct CalendarViewModel {
    let dayViewModels: [CalendarDayViewModel]
}

final class CalendarView: BaseView {
    
    // 7 X 6
    
    private let stackView = UIStackView()
    
    func setup(model: CalendarViewModel) {
        let dayViews = stackView.subviews.compactMap { $0 as? UIStackView }
            .flatMap { $0.subviews.compactMap { $0 as? CalendarDayView }}
        
        guard dayViews.count != model.dayViewModels.count else {
            print("캘린더의 크기가 7 X 6 이 아닙니다.")
            return
        }
        zip(dayViews, model.dayViewModels).forEach { view, model in
            view.setup(model: model)
        }
    }
    
    override func setupLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        (0..<6).forEach { _ in
            let hStackView = makeHorizontalStackView()
            (0..<7).forEach { _ in
                hStackView.addArrangedSubview(CalendarDayView())
            }
            stackView.addArrangedSubview(hStackView)
        }
    }
    
    override func setupAttributes() {
        stackView.do {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
    }
    
    private func makeHorizontalStackView() -> UIStackView {
        return UIStackView().with {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fillEqually
        }
    }
    
}
