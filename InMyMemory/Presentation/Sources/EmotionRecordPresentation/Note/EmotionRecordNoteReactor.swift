//
//  EmotionRecordNoteReactor.swift
//
//
//  Created by 홍성준 on 1/2/24.
//

import Foundation
import Entities
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
}

struct EmotionRecordNoteState {
    var isEnabled: Bool
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
    
    init(emotionType: EmotionType) {
        self.initialState = .init(
            isEnabled: false,
            note: nil,
            emotionType: emotionType
        )
    }
    
    func mutate(action: EmotionRecordNoteAction) -> Observable<EmotionRecordNoteMutation> {
        switch action {
        case .closeDidTap:
            steps.accept(AppStep.emotionRecordNoteIsComplete)
            return .empty()
            
        case .textDidUpdated(let text):
            return .just(.updateNote(text))
            
        case .nextDidTap:
            steps.accept(AppStep.emotionRecordCompleteIsRequired)
            return .empty()
        }
    }
    
    func reduce(state: EmotionRecordNoteState, mutation: EmotionRecordNoteMutation) -> EmotionRecordNoteState {
        var newState = state
        switch mutation {
        case .updateNote(let note):
            newState.note = note
            newState.isEnabled = !(note ?? "").isEmpty
        }
        return newState
    }
    
}
