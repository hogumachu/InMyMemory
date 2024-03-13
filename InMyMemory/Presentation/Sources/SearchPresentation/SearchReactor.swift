//
//  SearchReactor.swift
//
//
//  Created by 홍성준 on 1/15/24.
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

final class SearchReactor: Reactor, Stepper {
    
    enum Action {
        case search
        case updateKeyword(String?)
        case closeDidTap
        case itemDidTap(IndexPath)
    }
    
    struct State {
        var keyword: String?
        var isLoading: Bool = false
        var isEmpty: Bool = true
        var sections: [SearchSection] = []
    }
    
    enum Mutation {
        case setKeyword(String?)
        case setLoading(Bool)
        case setSections([Memory], [Emotion], [Todo])
    }
    
    var initialState: State = .init()
    let steps = PublishRelay<Step>()
    
    private let useCase: SearchUseCaseInterface
    private let formatter: DateFormatter
    
    init(
        useCase: SearchUseCaseInterface,
        formatter: DateFormatter = DateFormatter().with {
            $0.dateFormat = "yyyy년 MM월 dd일"
            $0.locale = Locale(identifier: "ko_KR")
        }
    ) {
        self.useCase = useCase
        self.formatter = formatter
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .search:
            guard let keyword = currentState.keyword else { return .empty() }
            return .concat([
                .just(.setLoading(true)),
                search(keyword: keyword),
                .just(.setLoading(false))
            ])
            
        case .updateKeyword(let keyword):
            return .just(.setKeyword(keyword))
            
        case .closeDidTap:
            steps.accept(AppStep.searchIsComplete)
            return .empty()
            
        case .itemDidTap(let indexPath):
            guard let item = currentState.sections[safe: indexPath.section]?.items[safe: indexPath.row] else {
                return .empty()
            }
            switch item {
            case .emotion(let model):
                steps.accept(AppStep.emotionDetailIsRequired(model.id))
                
            case .memory(let model):
                steps.accept(AppStep.memoryDetailIsRequired(model.id))
                
            case .todo(let model):
                print("Todo Did Tap")
            }
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setKeyword(let keyword):
            newState.keyword = keyword
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .setSections(let memories, let emotions, let todos):
            let sections = makeSections(
                memories: memories,
                emotions: emotions,
                todos: todos
            )
            newState.sections = sections
            newState.isEmpty = sections.isEmpty
        }
        return newState
    }
    
    private func search(keyword: String) -> Observable<Mutation> {
        let setSections = Observable.zip(
            useCase.fetchMemories(keyword: keyword).asObservable(),
            useCase.fetchEmotions(keyword: keyword).asObservable(),
            useCase.fetchTodos(keyword: keyword).asObservable()
        ).map(Mutation.setSections)
        return setSections
    }
    
    private func makeSections(memories: [Memory], emotions: [Emotion], todos: [Todo]) -> [SearchSection] {
        var sections: [SearchSection] = []
        if !memories.isEmpty {
            let items = memories
                .map { SearchResultMemoryCellModel(
                    id: $0.id,
                    note: $0.note,
                    imagteData: $0.images.first,
                    date: formatter.string(from: $0.date))
                }
                .map(SectionItem.memory)
            sections.append(.memory(items))
        }
        if !emotions.isEmpty {
            let items = emotions
                .map { SearchResultEmotionCellModel(
                    id: $0.id,
                    type: $0.emotionType,
                    note: $0.note,
                    date: formatter.string(from: $0.date))
                }
                .map(SectionItem.emotion)
            sections.append(.memory(items))
        }
        
        if !todos.isEmpty {
            let items = todos
                .map { SearchResultTodoCellModel(
                    id: $0.id,
                    note: $0.note,
                    isCompleted: $0.isCompleted,
                    date: formatter.string(from: $0.date))
                }
                .map(SectionItem.todo)
            sections.append(.todo(items))
        }
        return sections
    }
    
}
