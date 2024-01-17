//
//  EmotionRecordCompleteReactor.swift
//
//
//  Created by 홍성준 on 1/2/24.
//

import Foundation
import BasePresentation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow

enum EmotionRecordCompleteAction {
    case completeDidTap
}

struct EmotionRecordCompleteState {}

final class EmotionRecordCompleteReactor: Reactor, Stepper {
    
    typealias Action = EmotionRecordCompleteAction
    typealias State = EmotionRecordCompleteState
    
    var initialState: EmotionRecordCompleteState = .init()
    let steps = PublishRelay<Step>()
    
    func mutate(action: EmotionRecordCompleteAction) -> Observable<EmotionRecordCompleteAction> {
        switch action {
        case .completeDidTap:
            steps.accept(AppStep.emotionRecordCompleteIsComplete)
            return .empty()
        }
    }
    
}
