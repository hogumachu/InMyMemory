//
//  CalendarHomeReactor.swift
//  
//
//  Created by 홍성준 on 1/7/24.
//

import Foundation
import Entities
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
    }
    
    struct State {
        
    }
    
    enum Mutation {
        
    }
    
    var initialState: State = .init()
    let steps = PublishRelay<Step>()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .closeDidTap:
            steps.accept(AppStep.calendarIsComplete)
            return .empty()
            
        case .searchDidTap:
            return .empty()
            
        case .addDidTap:
            return .empty()
        }
    }
    
}
