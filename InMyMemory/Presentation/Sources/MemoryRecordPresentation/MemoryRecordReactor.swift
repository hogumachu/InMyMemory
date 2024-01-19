//
//  MemoryRecordReactor.swift
//
//
//  Created by 홍성준 on 1/12/24.
//

import Foundation
import Entities
import Interfaces
import BasePresentation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow

final class MemoryRecordReactor: Reactor, Stepper {
    
    enum Action {
        case closeDidTap
        case addDidTap
        case imageDidTap(Data?)
        case imageRemoveDidTap(Int)
        case nextDidTap
    }
    
    struct State {
        var images: [Data]
        var title: String
        let imageSize: Int
        let isPresent: Bool
    }
    
    enum Mutation {
        case appendImage(Data)
        case removeImage(index: Int)
    }
    
    var initialState: State
    let steps = PublishRelay<Step>()
    private let memory: Memory?
    private let date: Date
    
    init(
        isPresent: Bool = false,
        memory: Memory? = nil,
        imageSize: Int = 5,
        date: Date
    ) {
        self.memory = memory
        self.date = date
        self.initialState = .init(
            images: memory?.images ?? [],
            title: "\(memory?.images.count ?? 0)/\(imageSize)",
            imageSize: imageSize,
            isPresent: isPresent
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .closeDidTap:
            steps.accept(AppStep.memoryRecordIsComplete)
            return .empty()
            
        case .addDidTap:
            steps.accept(AppStep.memoryRecordPhotoIsRequired)
            return .empty()
            
        case .imageDidTap(let image):
            steps.accept(AppStep.memoryRecordPhotoIsComplete)
            if let image {
                return .just(.appendImage(image))
            } else {
                return .empty()
            }
            
        case .imageRemoveDidTap(let index):
            return .just(.removeImage(index: index))
            
        case .nextDidTap:
            steps.accept(AppStep.memoryRecordNoteIsRequired(currentState.images, date))
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .appendImage(let image):
            newState.images.append(image)
            newState.title = "\(newState.images.count)/\(state.imageSize)"
            
        case .removeImage(let index):
            newState.images.remove(at: index)
            newState.title = "\(newState.images.count)/\(state.imageSize)"
        }
        
        return newState
    }
    
}
