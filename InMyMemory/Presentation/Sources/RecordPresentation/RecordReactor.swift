//
//  RecordReactor.swift
//
//
//  Created by 홍성준 on 1/2/24.
//

import Foundation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow
import BasePresentation

enum RecordAction {
    case closeDidTap
    case emotionRecordDidTap
}

struct RecordState {
    
}

final class RecordReactor: Reactor, Stepper {
    
    typealias Action = RecordAction
    typealias State = RecordState
    
    var initialState: RecordState = .init()
    let steps = PublishRelay<Step>()
    
    func mutate(action: RecordAction) -> Observable<RecordAction> {
        switch action {
        case .closeDidTap:
            steps.accept(AppStep.recordIsComplete)
            return .empty()
            
        case .emotionRecordDidTap:
            steps.accept(AppStep.emotionRecordIsRequired)
            return .empty()
        }
    }
    
}
