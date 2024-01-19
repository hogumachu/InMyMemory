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
    
    var initialState: State
    let steps = PublishRelay<Step>()
    
    private let images: [Data]
    private let useCase: MemoryRecordUseCaseInterface
    private let memory: Memory?
    private let date: Date
    
    init(
        memory: Memory? = nil,
        images: [Data],
        date: Date,
        useCase: MemoryRecordUseCaseInterface
    ) {
        self.memory = memory
        self.images = images
        self.date = date
        self.useCase = useCase
        self.initialState = .init(
            note: memory?.note,
            isEnabled: false,
            isLoading: false
        )
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
                    id: memory?.id ?? UUID(),
                    images: images,
                    note: currentState.note ?? "",
                    date: date
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
