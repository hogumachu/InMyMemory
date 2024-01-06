//
//  HomeReactor.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import Foundation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow
import Interfaces
import BasePresentation

enum HomeAction {
    case recordDidTap
}

struct HomeState {
    
}

final class HomeReactor: Reactor, Stepper {
    
    typealias Action = HomeAction
    typealias State = HomeState
    
    var initialState: HomeState = .init()
    let steps = PublishRelay<Step>()
    
    private let useCase: HomeUseCaseInterface
    
    init(useCase: HomeUseCaseInterface) {
        self.useCase = useCase
    }
    
    func mutate(action: HomeAction) -> Observable<HomeAction> {
        switch action {
        case .recordDidTap:
            steps.accept(AppStep.recordIsRequired)
            return .empty()
        }
    }
    
    func reduce(state: HomeState, mutation: HomeAction) -> HomeState {
        let newState = state
        return newState
    }
    
}
