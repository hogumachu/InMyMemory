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


final class EmotionDetailReactor: Reactor, Stepper {
    
    enum Action {
        case refresh
        case closeDidTap
    }
    
    struct State {
        var emotion: Emotion?
        var viewModel: EmotionDetailViewModel?
        var isLoading: Bool = false
    }
    
    enum Mutation {
        case setEmotion(Emotion?)
        case setLoading(Bool)
    }
    
    var initialState: State = .init()
    let steps = PublishRelay<Step>()
    
    private let emotionID: UUID
    private let formatter: DateFormatter
    
    init(
        emotionID: UUID,
        formatter: DateFormatter = DateFormatter().with {
            $0.dateFormat = "yyyy년 MM월 dd일 E요일"
            $0.locale = Locale(identifier: "ko_KR")
        }
    ) {
        self.emotionID = emotionID
        self.formatter = formatter
    }
    
    func mutate(action: Action) -> Observable<State> {
        switch action {
        case .refresh:
            return .empty()
            
        case .closeDidTap:
            steps.accept(AppStep.emotionDetailIsComplete)
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setEmotion(let emotion):
            newState.emotion = emotion
            newState.viewModel = makeViewModel(emotion)
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        
        return newState
    }
    
    private func makeViewModel(_ emotion: Emotion?) -> EmotionDetailViewModel? {
        guard let emotion else {
            return nil
        }
        return .init(
            date: formatter.string(from: emotion.date),
            note: emotion.note,
            emotionType: emotion.emotionType
        )
    }
    
}
