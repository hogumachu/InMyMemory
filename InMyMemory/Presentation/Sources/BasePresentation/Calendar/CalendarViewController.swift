//
//  CalendarViewController.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import UIKit
import CoreKit
import Entities
import DesignKit
import RxSwift
import RxCocoa
import ReactorKit
import Then
import SnapKit

public final class CalendarViewController: EmptyBaseViewController {
    
    fileprivate let monthView = CalendarMonthView()
    private let dayOfWeekView = CalendarDayOfWeekView()
    fileprivate let calendarView = CalendarView()
    
    public override func setupLayout() {
        view.addSubview(monthView)
        monthView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(dayOfWeekView)
        dayOfWeekView.snp.makeConstraints { make in
            make.top.equalTo(monthView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(dayOfWeekView.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    public override func setupAttributes() {
        view.backgroundColor = .background
    }
    
}

public extension Reactive where Base: CalendarViewController {
    
    var monthTitle: Binder<String?> {
        return base.monthView.rx.title
    }
    
    var monthLeftButtonDidTap: ControlEvent<Void> {
        let source = base.monthView.rx.leftButtonDidTap
        return ControlEvent(events: source)
    }
    
    var monthRightButtonDidTap: ControlEvent<Void> {
        let source = base.monthView.rx.rightButtonDidTap
        return ControlEvent(events: source)
    }
    
    var dayDidTap: ControlEvent<Int> {
        let source = base.calendarView.rx.dayTap
        return ControlEvent(events: source)
    }
    
    var calendarViewModel: Binder<CalendarViewModel> {
        return base.calendarView.rx.viewModel
    }
    
}
