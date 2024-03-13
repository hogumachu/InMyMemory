//
//  EmotionDetailReactor.swift
//
//
//  Created by 홍성준 on 3/13/24.
//

import Foundation
import Entities
import Interfaces
import BasePresentation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow

enum EmotionDetailAction {
    
}

struct EmotionDetailState {
    
}

final class EmotionDetailReactor: Reactor, Stepper {
    
    typealias Action = EmotionDetailAction
    typealias State = EmotionDetailState
    
    var initialState: EmotionDetailState = .init()
    let steps = PublishRelay<Step>()
    
    private let emotionID: UUID
    
    init(emotionID: UUID) {
        self.emotionID = emotionID
    }
    
    func mutate(action: EmotionDetailAction) -> Observable<EmotionDetailAction> {
        
    }
    
}
