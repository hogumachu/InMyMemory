//
//  MemoryDetailReactor.swift
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
import Then

final class MemoryDetailReactor: Reactor, Stepper {
    
    enum Action {
        case refresh
        case removeDidTap
        case editDidTap
        case closeDidTap
    }
    
    struct State {
        var memory: Memory?
        var viewModel: MemoryDetailViewModel?
        var isLoading: Bool = false
    }
    
    enum Mutation {
        case setMemory(Memory?)
        case setLoading(Bool)
    }
    
    var initialState: State = .init()
    let steps = PublishRelay<Step>()
    
    private let memoryID: UUID
    private let useCase: MemoryDetailUseCaseInterface
    private let formatter: DateFormatter
    
    init(
        memoryID: UUID,
        useCase: MemoryDetailUseCaseInterface,
        formatter: DateFormatter = DateFormatter().with {
            $0.dateFormat = "yyyy년 MM월 dd일 E요일"
            $0.locale = Locale(identifier: "ko_KR")
        }
    ) {
        self.memoryID = memoryID
        self.useCase = useCase
        self.formatter = formatter
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .closeDidTap:
            steps.accept(AppStep.memoryDetailIsComplete)
            return .empty()
            
        case .removeDidTap:
            return .concat([
                .just(.setLoading(true)),
                useCase.remove(memoryID: memoryID)
                    .map { [weak self] _ in
                        self?.steps.accept(AppStep.memoryDetailIsComplete)
                        return Mutation.setLoading(true)
                    }
                    .asObservable()
            ])
            
        case .editDidTap:
            guard let memory = currentState.memory else { return .empty() }
            steps.accept(AppStep.memoryEditIsRequired(memory))
            return .empty()
            
        case .refresh:
            return .concat([
                .just(.setLoading(true)),
                useCase
                    .memory(id: memoryID)
                    .map { Mutation.setMemory($0) }
                    .asObservable(),
                .just(.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setMemory(let memory):
            newState.memory = memory
            newState.viewModel = makeViewModel(memory)
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        
        return newState
    }
    
    private func makeViewModel(_ memory: Memory?) -> MemoryDetailViewModel {
        guard let memory else { return .init(date: "", note: "", images: []) }
        return .init(
            date: formatter.string(from: memory.date),
            note: memory.note,
            images: memory.images
        )
    }
    
}
