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
        case viewDidLoad
        case closeDidTap
    }
    
    struct State {
        var viewModel: MemoryDetailViewModel?
    }
    
    enum Mutation {
        case setMemory(Memory?)
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
            
        case .viewDidLoad:
            return useCase
                .memory(id: memoryID)
                .map { Mutation.setMemory($0) }
                .asObservable()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setMemory(let memory):
            newState.viewModel = makeViewModel(memory)
            
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
