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
    
    func mutate(action: HomeAction) -> Observable<HomeAction> {
        switch action {
        case .recordDidTap:
            steps.accept(AppStep.emotionRecordIsRequired)
            return .empty()
        }
    }
    
    func reduce(state: HomeState, mutation: HomeAction) -> HomeState {
        var newState = state
        return newState
    }
    
}
