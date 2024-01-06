//
//  EmotionRecordReactor.swift
//
//
//  Created by 홍성준 on 1/2/24.
//

import Foundation
import Entities
import Interfaces
import BasePresentation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow

enum EmotionRecordAction {
    case closeDidTap
    case buttonDidTap(EmotionType)
}

struct EmotionRecordState {
    
}

final class EmotionRecordReactor: Reactor, Stepper {
    
    typealias Action = EmotionRecordAction
    typealias State = EmotionRecordState
    
    var initialState: EmotionRecordState = .init()
    let steps = PublishRelay<Step>()
    
    private let useCase: EmotionRecordUseCaseInterface
    
    init(useCase: EmotionRecordUseCaseInterface) {
        self.useCase = useCase
    }
    
    func mutate(action: EmotionRecordAction) -> Observable<EmotionRecordAction> {
        switch action {
        case .closeDidTap:
            steps.accept(AppStep.emotionRecordIsComplete)
            return .empty()
            
        case .buttonDidTap(let emotionType):
            steps.accept(AppStep.emotionRecordNoteIsRequired(emotionType))
            return .empty()
        }
    }
    
}
