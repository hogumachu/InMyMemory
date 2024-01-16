//
//  SearchReactor.swift
//
//
//  Created by 홍성준 on 1/15/24.
//

import Foundation
import Entities
import Interfaces
import BasePresentation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow

final class SearchReactor: Reactor, Stepper {
    
    enum Action {
        case search(String)
        case closeDidTap
        case itemDidTap(IndexPath)
    }
    
    struct State {
        var sections: [SearchSection] = []
    }
    
    enum Mutation {
        case setSections([SearchSection])
    }
    
    var initialState: State = .init()
    let steps = PublishRelay<Step>()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .search(let keyword):
            print(keyword)
            return .just(.setSections([
                .emotion([.emotion(.init(id: .init(), type: .good, note: "TEST 123", date: "2024년 1월 15일"))]),
                .memory([.memory(.init(id: .init(), note: "TEST 123456", imagteData: nil, date: "2024년 1월 14일"))]),
                .todo([
                    .todo(.init(id: .init(), note: "TEST 1234", isCompleted: true, date: "2024년 1월 16일")),
                    .todo(.init(id: .init(), note: "TEST 1234", isCompleted: false, date: "2024년 1월 16일")),
                ])
            ]))
            
        case .closeDidTap:
            steps.accept(AppStep.searchIsComplete)
            return .empty()
            
        case .itemDidTap(let indexPath):
            
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSections(let sections):
            newState.sections = sections
        }
        return newState
    }
    
}
