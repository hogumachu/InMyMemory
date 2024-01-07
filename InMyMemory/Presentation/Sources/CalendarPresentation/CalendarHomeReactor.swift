//
//  CalendarHomeReactor.swift
//  
//
//  Created by 홍성준 on 1/7/24.
//

import Foundation
import Entities
import CoreKit
import BasePresentation
import RxSwift
import RxRelay
import RxFlow
import ReactorKit

final class CalendarHomeReactor: Reactor, Stepper {
    
    enum Action {
        case closeDidTap
        case searchDidTap
        case addDidTap
        case monthLeftDidTap
        case monthRightDidTap
    }
    
    struct State {
        var date: Date
        var monthTitle: String
    }
    
    enum Mutation {
        case setDate(Date)
        case setMonthTitle(String)
    }
    
    var initialState: State
    let steps = PublishRelay<Step>()
    
    init() {
        let date = Date()
        self.initialState = .init(
            date: date, 
            monthTitle: "\(date.year)년 \(date.month)월"
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .closeDidTap:
            steps.accept(AppStep.calendarIsComplete)
            return .empty()
            
        case .searchDidTap:
            return .empty()
            
        case .addDidTap:
            return .empty()
            
        case .monthLeftDidTap:
            let date = currentState.date.monthsAgo(value: 1)
            let title = "\(date.year)년 \(date.month)월"
            return Observable.concat([
                .just(.setDate(date)),
                .just(.setMonthTitle(title))
            ])
            
        case .monthRightDidTap:
            let date = currentState.date.monthsAgo(value: -1)
            let title = "\(date.year)년 \(date.month)월"
            return Observable.concat([
                .just(.setDate(date)),
                .just(.setMonthTitle(title))
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
        }
        return newState
    }
    
}
