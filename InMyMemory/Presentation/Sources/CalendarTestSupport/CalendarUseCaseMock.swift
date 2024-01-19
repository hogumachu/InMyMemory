//
//  CalendarUseCaseMock.swift
//
//
//  Created by 홍성준 on 1/17/24.
//

import Interfaces
import Entities
import RxSwift

public final class CalendarUseCaseMock: CalendarUseCaseInterface {
    
    public init() {}
    
    public var fetchDaysInMonthYearMonthCallCount = 0
    public var fetchDaysInMonthYearMonthYear: Int?
    public var fetchDaysInMonthYearMonthMonth: Int?
    public var fetchDaysInMonthYearMonthDays: [Day] = []
    public func fetchDaysInMonth(year: Int, month: Int) -> Single<[Day]> {
        fetchDaysInMonthYearMonthCallCount += 1
        fetchDaysInMonthYearMonthYear = year
        fetchDaysInMonthYearMonthMonth = month
        return .just(fetchDaysInMonthYearMonthDays)
    }
    
}
