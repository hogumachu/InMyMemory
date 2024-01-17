//
//  EmotionRecordNoteReactor.swift
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

enum EmotionRecordNoteAction {
    case closeDidTap
    case textDidUpdated(String?)
    case nextDidTap
}

enum EmotionRecordNoteMutation {
    case updateNote(String?)
    case setLoading(Bool)
}

struct EmotionRecordNoteState {
    var isEnabled: Bool
    var isLoading: Bool
    var note: String?
    let emotionType: EmotionType
}

final class EmotionRecordNoteReactor: Reactor, Stepper {
    
    typealias Action = EmotionRecordNoteAction
    typealias Mutation = EmotionRecordNoteMutation
    typealias State = EmotionRecordNoteState
    
    var initialState: EmotionRecordNoteState
    let steps = PublishRelay<Step>()
    private var note: String?
    private let useCase: EmotionRecordUseCaseInterface
    
    init(emotionType: EmotionType, useCase: EmotionRecordUseCaseInterface) {
        self.initialState = .init(
            isEnabled: false,
            isLoading: false,
            note: nil,
            emotionType: emotionType
        )
        self.useCase = useCase
    }
    
    func mutate(action: EmotionRecordNoteAction) -> Observable<EmotionRecordNoteMutation> {
        switch action {
        case .closeDidTap:
            steps.accept(AppStep.emotionRecordNoteIsComplete)
            return .empty()
            
        case .textDidUpdated(let text):
            return .just(.updateNote(text))
            
        case .nextDidTap:
            return Observable.concat([
                .just(.setLoading(true)),
                useCase.createEmotion(.init(
                    note: currentState.note ?? "",
                    emotionType: currentState.emotionType,
                    date: Date()
                )).map { [weak self] _ in
                    self?.steps.accept(AppStep.emotionRecordCompleteIsRequired)
                    return Mutation.setLoading(false)
                }.asObservable()
            ])
        }
    }
    
    func reduce(state: EmotionRecordNoteState, mutation: EmotionRecordNoteMutation) -> EmotionRecordNoteState {
        var newState = state
        switch mutation {
        case .updateNote(let note):
            newState.note = note
            newState.isEnabled = !(note ?? "").isEmpty
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
    
}
