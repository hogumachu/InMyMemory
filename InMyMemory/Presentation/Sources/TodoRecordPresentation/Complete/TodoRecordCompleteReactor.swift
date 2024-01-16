//
//  TodoRecordCompleteReactor.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import Foundation
import BasePresentation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow

final class TodoRecordCompleteReactor: Reactor, Stepper {
    
    enum Action {
        case completeDidTap
    }
    
    struct State {
        
    }
    
    enum Mutation {
        
    }
    
    var initialState: State = .init()
    let steps = PublishRelay<Step>()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .completeDidTap:
            steps.accept(AppStep.todoRecordCompleteIsComplete)
            return .empty()
        }
    }
    
}
