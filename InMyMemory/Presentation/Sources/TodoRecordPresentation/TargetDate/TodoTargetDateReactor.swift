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
        case closeDidTap
    }
    
    struct State {
        
    }
    
    enum Mutation {
        
    }
    
    var initialState: State = .init()
    let steps = PublishRelay<Step>()
    
    private let todos: [String]
    
    init(todos: [String]) {
        self.todos = todos
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .closeDidTap:
            steps.accept(AppStep.todoTargetDateIsComplete)
            return .empty()
        }
    }
    
}
