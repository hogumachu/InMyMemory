//
//  HomeReactor.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import Foundation
import Entities
import Interfaces
import BasePresentation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow

enum HomeAction {
    case refresh
    case recordDidTap
}

struct HomeState {
    var isLoading: Bool
    var memories: [Memory]
    var todos: [Todo]
}

enum HomeMutation {
    case setLoading(Bool)
    case setMemories([Memory])
    case setTodos([Todo])
}

final class HomeReactor: Reactor, Stepper {
    
    typealias Action = HomeAction
    typealias State = HomeState
    typealias Mutation = HomeMutation
    
    var initialState: HomeState = .init(
        isLoading: false,
        memories: [],
        todos: []
    )
    let steps = PublishRelay<Step>()
    
    private let useCase: HomeUseCaseInterface
    
    init(useCase: HomeUseCaseInterface) {
        self.useCase = useCase
    }
    
    func mutate(action: HomeAction) -> Observable<HomeMutation> {
        switch action {
        case .refresh:
            return Observable.concat([
                .just(.setLoading(true)),
                useCase.fetchLastSevenDaysMemories()
                    .map { Mutation.setMemories($0) }
                    .asObservable(),
                useCase.fetchCurrentWeekTodos()
                    .map { Mutation.setTodos($0) }
                    .asObservable(),
                .just(.setLoading(false))
            ])
        case .recordDidTap:
            steps.accept(AppStep.recordIsRequired)
            return .empty()
        }
    }
    
    func reduce(state: HomeState, mutation: HomeMutation) -> HomeState {
        var newState = state
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .setMemories(let memories):
            newState.memories = memories
            
        case .setTodos(let todos):
            newState.todos = todos
        }
        
        return newState
    }
    
    
}
