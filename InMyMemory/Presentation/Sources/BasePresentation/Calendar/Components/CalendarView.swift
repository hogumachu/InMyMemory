//
//  CalendarView.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit
import DesignKit
import RxSwift
import RxCocoa
import RxRelay
import SnapKit
import Then

public struct CalendarViewModel {
    public let dayViewModels: [CalendarDayViewModel]
    
    public init(dayViewModels: [CalendarDayViewModel]) {
        self.dayViewModels = dayViewModels
    }
}

public final class CalendarView: BaseView {
    
    // 7 X 6
    
    fileprivate let dayRelay = PublishRelay<Int>()
    private let stackView = UIStackView()
    fileprivate var viewModelBinder: Binder<CalendarViewModel> {
        return Binder(self) { this, viewModel in
            this.setup(model: viewModel)
        }
    }
    
    public func setup(model: CalendarViewModel) {
        let dayViews = stackView.subviews.compactMap { $0 as? UIStackView }
            .flatMap { $0.subviews.compactMap { $0 as? CalendarDayView }}
        dayViews.forEach { $0.clear() }
        
        zip(dayViews, model.dayViewModels).forEach { view, model in
            view.setup(model: model)
            view.rx.recognizedTap
                .filter { model.isValid }
                .map { _ in model.day }
                .bind(to: dayRelay)
                .disposed(by: disposeBag)
        }
    }
    
    public override func setupLayout() {
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
    
    public override func setupAttributes() {
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

public extension Reactive where Base: CalendarView {
    
    var viewModel: Binder<CalendarViewModel> {
        return base.viewModelBinder
    }
    
    var dayTap: ControlEvent<Int> {
        let source = base.dayRelay
        return ControlEvent(events: source)
    }
    
}
