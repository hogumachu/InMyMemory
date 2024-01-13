//
//  MemoryRecordNoteReactor.swift
//
//
//  Created by 홍성준 on 1/13/24.
//

import Foundation
import Entities
import Interfaces
import BasePresentation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow

final class MemoryRecordNoteReactor: Reactor, Stepper {
    
    enum Action {
        case textDidUpdated(String?)
        case closeDidTap
        case nextDidTap
    }
    
    struct State {
        var note: String?
        var isEnabled: Bool
    }
    
    enum Mutation {
        case updateNote(String?)
    }
    
    var initialState: State = .init(note: nil, isEnabled: false)
    let steps = PublishRelay<Step>()
    
    private let images: [Data]
    
    init(images: [Data]) {
        self.images = images
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .textDidUpdated(let note):
            return .just(.updateNote(note))
            
        case .closeDidTap:
            steps.accept(AppStep.memoryRecordNoteIsComplete)
            return .empty()
            
        case .nextDidTap:
            steps.accept(AppStep.memoryRecordCompleteIsRequired)
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateNote(let note):
            newState.note = note
            newState.isEnabled = !(note ?? "").isEmpty
        }
        return newState
    }
    
}
