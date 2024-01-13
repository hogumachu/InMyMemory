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
        var isLoading: Bool
    }
    
    enum Mutation {
        case updateNote(String?)
        case setLoading(Bool)
    }
    
    var initialState: State = .init(note: nil, isEnabled: false, isLoading: false)
    let steps = PublishRelay<Step>()
    
    private let images: [Data]
    private let useCase: MemoryRecordUseCaseInterface
    
    init(images: [Data], useCase: MemoryRecordUseCaseInterface) {
        self.images = images
        self.useCase = useCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .textDidUpdated(let note):
            return .just(.updateNote(note))
            
        case .closeDidTap:
            steps.accept(AppStep.memoryRecordNoteIsComplete)
            return .empty()
            
        case .nextDidTap:
            return Observable.concat([
                .just(.setLoading(true)),
                useCase.createMemory(.init(
                    images: images,
                    note: currentState.note ?? "",
                    date: Date()
                )).map { [weak self] _ in
                    self?.steps.accept(AppStep.memoryRecordCompleteIsRequired)
                    return Mutation.setLoading(false)
                }.asObservable()
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
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
