//
//  EmotionRecordReactor.swift
//
//
//  Created by 홍성준 on 1/2/24.
//

import Foundation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow

enum EmotionRecordAction {
    
}

struct EmotionRecordState {
    
}

final class EmotionRecordReactor: Reactor, Stepper {
    
    typealias Action = EmotionRecordAction
    typealias State = EmotionRecordState
    
    var initialState: EmotionRecordState = .init()
    let steps = PublishRelay<Step>()
    
}
