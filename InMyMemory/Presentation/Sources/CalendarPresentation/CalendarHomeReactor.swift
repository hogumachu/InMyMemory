//
//  CalendarHomeReactor.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import Foundation
import Entities
import CoreKit
import Interfaces
import BasePresentation
import RxSwift
import RxRelay
import RxFlow
import ReactorKit

final class CalendarHomeReactor: Reactor, Stepper {
    
    enum Action {
        case viewDidLoad
        case closeDidTap
        case searchDidTap
        case addDidTap
        case monthLeftDidTap
        case monthRightDidTap
        case dayDidTap(Int)
    }
    
    struct State {
        var date: Date
        var monthTitle: String
        var selectDay: Int?
        var days: [Day]
        var calendarViewModel: CalendarViewModel?
        var calendarListSections: [CalendarListSection]
    }
    
    enum Mutation {
        case setDate(Date)
        case setMonthTitle(String)
        case setSelectDay(Int?)
        case setDays([Day])
    }
    
    var initialState: State
    let steps = PublishRelay<Step>()
    
    private let useCase: CalendarUseCaseInterface
    
    init(useCase: CalendarUseCaseInterface, date: Date = .init()) {
        self.useCase = useCase
        self.initialState = .init(
            date: date,
            monthTitle: "\(date.year)년 \(date.month)월",
            selectDay: date.day,
            days: [],
            calendarListSections: []
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let date = currentState.date
            return Observable.concat([
                useCase.fetchDaysInMonth(year: date.year, month: date.month)
                    .map { Mutation.setDays($0) }
                    .asObservable(),
                .just(.setSelectDay(date.day))
            ])
            
        case .closeDidTap:
            steps.accept(AppStep.calendarIsComplete)
            return .empty()
            
        case .searchDidTap:
            steps.accept(AppStep.searchIsRequired)
            return .empty()
            
        case .addDidTap:
            return .empty()
            
        case .monthLeftDidTap:
            let date = currentState.date.monthsAgo(value: 1)
            let title = "\(date.year)년 \(date.month)월"
            return Observable.concat([
                .just(.setDate(date)),
                .just(.setMonthTitle(title)),
                .just(.setSelectDay(nil)),
                useCase.fetchDaysInMonth(year: date.year, month: date.month)
                    .map { Mutation.setDays($0) }
                    .asObservable()
            ])
            
        case .monthRightDidTap:
            let date = currentState.date.monthsAgo(value: -1)
            let title = "\(date.year)년 \(date.month)월"
            return Observable.concat([
                .just(.setDate(date)),
                .just(.setMonthTitle(title)),
                .just(.setSelectDay(nil)),
                useCase.fetchDaysInMonth(year: date.year, month: date.month)
                    .map { Mutation.setDays($0) }
                    .asObservable()
            ])
            
        case .dayDidTap(let day):
            return .just(.setSelectDay(day))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setDate(let date):
            newState.date = date
            
        case .setMonthTitle(let title):
            newState.monthTitle = title
            
        case .setDays(let days):
            newState.days = days
            newState.calendarViewModel = makeCalendarViewModel(days)
            
        case .setSelectDay(let day):
            newState.selectDay = day
            newState.calendarListSections = makeCalendarListSections(state.days, selectDay: day)
            if let viewModel = currentState.calendarViewModel {
                newState.calendarViewModel = makeCalendarViewModel(previous: viewModel, selectDay: day)
            }
        }
        return newState
    }
    
    private func makeCalendarViewModel(_ days: [Day]) -> CalendarViewModel {
        let dayViewModels = days.map { day -> CalendarDayViewModel in
            guard day.metadata.isValid else {
                return .init(day: 0, isToday: false, isSelected: false, isValid: false, emotionType: nil)
            }
            let isToday = currentState.date.year == Date.now.year && currentState.date.month == Date.now.month && day.metadata.number == Date.now.day
            let isSelected = day.metadata.number == currentState.selectDay
            return .init(
                day: day.metadata.number,
                isToday: isToday,
                isSelected: isSelected,
                isValid: true,
                emotionType: day.items.emotionType()
            )
        }
        return .init(dayViewModels: dayViewModels)
    }
    
    private func makeCalendarViewModel(previous viewModel: CalendarViewModel, selectDay: Int?) -> CalendarViewModel {
        let dayViewModels = viewModel.dayViewModels.map { model -> CalendarDayViewModel in
            guard model.isValid else { return model }
            let isSelected = model.day == selectDay
            return .init(
                day: model.day,
                isToday: model.isToday,
                isSelected: isSelected,
                isValid: true,
                emotionType: model.emotionType
            )
        }
        return .init(dayViewModels: dayViewModels)
    }
    
    private func makeCalendarListSections(_ days: [Day], selectDay: Int?) -> [CalendarListSection] {
        guard let selectDay else { return [] }
        var emotionItems: [CalendarListItem] = []
        var memoryItems: [CalendarListItem] = []
        var todoItems: [CalendarListItem] = []
        
        days.filter { $0.metadata.isValid && $0.metadata.date.day == selectDay }
            .flatMap { $0.items }
            .forEach { item in
                switch item {
                case .emotion(let emotion):
                    emotionItems.append(.emotion(.init(type: emotion.emotionType, note: emotion.note)))
                    
                case .memory(let memory):
                    memoryItems.append(.memory(.init(note: memory.note, imageData: memory.images.first)))
                    
                case .todo(let todo):
                    todoItems.append(.todo(.init(note: todo.note, isCompleted: todo.isCompleted)))
                }
            }
        
        return [
            .todo(todoItems),
            .memory(memoryItems),
            .emotion(emotionItems)
        ].filter { !$0.items.isEmpty }
    }
    
}

private extension Array where Element == DayItem {
    
    func emotionType() -> EmotionType? {
        for item in self {
            switch item {
            case .emotion(let emotion):
                return emotion.emotionType
            default:
                continue
            }
        }
        return nil
    }
    
}
