//
//  TodoUseCase.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import Foundation
import Entities
import Interfaces
import CoreKit
import RxSwift

public final class TodoUseCase: TodoUseCaseInterface {
    
    private let todoRepository: TodoRepositoryInterface
    private let calendar: Calendar
    
    public init(todoRepository: TodoRepositoryInterface, calendar: Calendar = .current) {
        self.todoRepository = todoRepository
        self.calendar = calendar
    }
    
    public func fetchDaysInMonth(year: Int, month: Int) -> Single<[Day]> {
        return .just(makeDays(year: year, month: month))
    }
    
    public func createTodo(_ todo: Todo) -> Single<Void> {
        return todoRepository.create(todo: todo)
    }
    
    private func makeDays(year: Int, month: Int) -> [Day] {
        return makeDaysInMonth(year: year, month: month)
            .map { metadata in
                return .init(metadata: metadata, items: [])
            }
    }
    
    private func makeDaysInMonth(year: Int, month: Int) -> [DayMetaData] {
        let monthMetadata = makeMonthMetadata(year: year, month: month)
        return (1..<(monthMetadata.numberOfDays + monthMetadata.firstDateOffset))
            .map { day in
                return makeDayMetadata(
                    offset: day - monthMetadata.firstDateOffset,
                    baseDate: monthMetadata.firstDate,
                    isValid: day >= monthMetadata.firstDateOffset
                )
            }
    }
    
    private func makeDayMetadata(offset: Int, baseDate: Date, isValid: Bool) -> DayMetaData {
        let date = Calendar.current.date(byAdding: .day, value: offset, to: baseDate) ?? baseDate
        return DayMetaData(date: date, number: date.day, isValid: isValid)
    }
    
    private func makeMonthMetadata(year: Int, month: Int) -> MonthMetadata {
        let firstDate = firstDate(year: year, month: month)
        let numberOfDays = numberOfDaysInMonth(date: firstDate)
        let offset = Calendar.current.component(.weekday, from: firstDate)
        return .init(
            numberOfDays: numberOfDays,
            firstDate: firstDate,
            firstDateOffset: offset
        )
    }
    
    private func firstDate(year: Int, month: Int) -> Date {
        return calendar.date(from: .init(
            year: year,
            month: month,
            day: 1
        ))!
    }
    
    private func numberOfDaysInMonth(date: Date) -> Int {
        return calendar.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
}
