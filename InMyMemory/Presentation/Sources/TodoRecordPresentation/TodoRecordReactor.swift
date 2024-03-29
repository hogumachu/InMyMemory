//
//  TodoRecordReactor.swift
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

final class TodoRecordReactor: Reactor, Stepper {
    
    enum Action {
        case closeDidTap
        case nextDidTap
        case todoUpdated(String)
        case todoRemoved(IndexPath)
    }
    
    struct State {
        var todos: [String] = []
        var isEnabled: Bool = false
    }
    
    enum Mutation {
        case removeTodo(IndexPath)
        case appendTodo(String)
    }
    
    var initialState: State = .init()
    let steps = PublishRelay<Step>()
    
    private let date: Date
    
    init(date: Date) {
        self.date = date
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .closeDidTap:
            steps.accept(AppStep.todoRecordIsComplete)
            return .empty()
            
        case .nextDidTap:
            steps.accept(AppStep.todoTargetDateIsRequired(currentState.todos, date))
            return .empty()
            
        case .todoUpdated(let todo):
            if !todo.isEmpty {
                return .just(.appendTodo(todo))
            } else {
                return .empty()
            }
            
        case .todoRemoved(let indexPath):
            return .just(.removeTodo(indexPath))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .removeTodo(let indexPath):
            if newState.todos.indices ~= indexPath.row {
                newState.todos.remove(at: indexPath.row)
            }
            newState.isEnabled = !newState.todos.isEmpty
            
        case .appendTodo(let todo):
            newState.todos.append(todo)
            newState.isEnabled = !newState.todos.isEmpty
        }
        return newState
    }
    
    
}
