//
//  CalendarUseCase.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import Foundation
import Entities
import Interfaces
import CoreKit
import RxSwift

public final class CalendarUseCase: CalendarUseCaseInterface {
    
    private let emotionRepository: EmotionRepositoryInterface
    private let memoryRepository: MemoryRepositoryInterface
    private let todoRepository: TodoRepositoryInterface
    
    public init(
        emotionRepository: EmotionRepositoryInterface,
        memoryRepository: MemoryRepositoryInterface,
        todoRepository: TodoRepositoryInterface
    ) {
        self.emotionRepository = emotionRepository
        self.memoryRepository = memoryRepository
        self.todoRepository = todoRepository
    }
    
    public func fetchDaysInMonth(year: Int, month: Int) -> Single<[Day]> {
        return Observable.zip(
            fetchEmotions(year: year, month: month).asObservable(),
            fetchMemories(year: year, month: month).asObservable(),
            fetchTodos(year: year, month: month).asObservable()
        )
        .compactMap { [weak self] emotions, memories, todos in
            return self?.makeDays(year: year, month: month, emotions: emotions, memories: memories, todos: todos)
        }
        .asSingle()
    }
    
    private func makeDays(year: Int, month: Int, emotions: [Emotion], memories: [Memory], todos: [Todo]) -> [Day] {
        return makeDaysInMonth(year: year, month: month)
            .map { metadata in
                guard metadata.isValid else {
                    return .init(metadata: metadata, items: [])
                }
                let emotionItems: [DayItem] = emotions.filter { $0.date.day == metadata.number }.map { .emotion($0) }
                let memoryItems: [DayItem] = memories.filter { $0.date.day == metadata.number }.map { .memory($0) }
                let todoItems: [DayItem] = todos.filter { $0.date.day == metadata.number }.map { .todo($0) }
                return .init(metadata: metadata, items: emotionItems + memoryItems + todoItems)
            }
    }
    
    private func fetchEmotions(year: Int, month: Int) -> Single<[Emotion]> {
        let startDate = firstDate(year: year, month: month)
        let endDate = startDate.monthsAgo(value: -1)
        return emotionRepository.read(greaterOrEqualThan: startDate, lessThan: endDate)
    }
    
    private func fetchMemories(year: Int, month: Int) -> Single<[Memory]> {
        let startDate = firstDate(year: year, month: month)
        let endDate = startDate.monthsAgo(value: -1)
        return memoryRepository.read(greaterOrEqualThan: startDate, lessThan: endDate)
    }
    
    private func fetchTodos(year: Int, month: Int) -> Single<[Todo]> {
        let startDate = firstDate(year: year, month: month)
        let endDate = startDate.monthsAgo(value: -1)
        return todoRepository.read(greaterOrEqualThan: startDate, lessThan: endDate)
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
        return Calendar.current.date(from: .init(
            year: year,
            month: month,
            day: 1
        ))!
    }
    
    private func numberOfDaysInMonth(date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
}
