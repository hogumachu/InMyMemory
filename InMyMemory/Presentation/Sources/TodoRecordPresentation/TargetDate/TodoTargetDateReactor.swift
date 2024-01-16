//
//  TodoTargetDateReactor.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import Foundation
import Entities
import Interfaces
import BasePresentation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow

final class TodoTargetDateReactor: Reactor, Stepper {
    
    enum Action {
        case viewDidLoad
        case closeDidTap
        case monthLeftDidTap
        case monthRightDidTap
        case dayDidTap(Int)
        case createDidTap
    }
    
    struct State {
        var date: Date
        var monthTitle: String
        var selectDay: Int?
        var days: [Day] = []
        var calendarViewModel: CalendarViewModel?
        var isLoading = false
    }
    
    enum Mutation {
        case setDate(Date)
        case setDays([Day])
        case setSelectDay(Int?)
        case setMonthTitle(String)
        case setLoading(Bool)
    }
    
    var initialState: State
    let steps = PublishRelay<Step>()
    
    private let useCase: TodoUseCaseInterface
    private let todos: [String]
    
    init(useCase: TodoUseCaseInterface, todos: [String]) {
        self.useCase = useCase
        self.todos = todos
        let date = Date()
        self.initialState = .init(
            date: date,
            monthTitle: "\(date.year)년 \(date.month)월",
            selectDay: date.day,
            days: []
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
            steps.accept(AppStep.todoTargetDateIsComplete)
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
            
        case .createDidTap:
            guard let day = currentState.selectDay else {
                return .empty()
            }
            return .concat([
                .just(.setLoading(true)),
                requestCreateTodos(todos: todos, targetDate: currentState.date.replace(day: day))
                    .map { [weak self] _ in
                        self?.steps.accept(AppStep.todoTargetDateIsComplete)
                        return Mutation.setLoading(false)
                    }
            ])
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
            
            if let viewModel = currentState.calendarViewModel {
                newState.calendarViewModel = makeCalendarViewModel(previous: viewModel, selectDay: day)
            }
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
    
    private func requestCreateTodos(todos: [String], targetDate: Date) -> Observable<[Void]> {
        let todoEntities = makeTodos(todos: todos, targetDate: targetDate)
        return Observable.zip(todoEntities.map { useCase.createTodo($0).asObservable() })
    }
    
    private func makeTodos(todos: [String], targetDate: Date) -> [Todo] {
        return todos.map { todo in
            return .init(id: .init(), note: todo, isCompleted: false, date: targetDate)
        }
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
                emotionType: nil
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
    
}
