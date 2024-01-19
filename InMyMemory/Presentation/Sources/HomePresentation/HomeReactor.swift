//
//  HomeReactor.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import Foundation
import Entities
import Interfaces
import BasePresentation
import RxSwift
import RxRelay
import ReactorKit
import RxFlow

enum HomeAction {
    case refresh
    case refreshEmotion
    case refreshMemory
    case recordDidTap
    case calendarDidTap
    case memoryDidTap(UUID)
}

struct HomeState {
    var isLoading: Bool
    var emotionViewModel: EmotionHomeViewModel?
    var memoryViewModel: MemoryHomeViewModel?
}

enum HomeMutation {
    case setLoading(Bool)
    case setMemories([Memory], [Todo])
    case setEmotions([Emotion])
}

final class HomeReactor: Reactor, Stepper {
    
    typealias Action = HomeAction
    typealias State = HomeState
    typealias Mutation = HomeMutation
    
    var initialState: HomeState = .init(isLoading: false)
    let steps = PublishRelay<Step>()
    
    private let useCase: HomeUseCaseInterface
    
    init(useCase: HomeUseCaseInterface) {
        self.useCase = useCase
    }
    
    func mutate(action: HomeAction) -> Observable<HomeMutation> {
        switch action {
        case .refresh:
            return Observable.concat([
                .just(.setLoading(true)),
                refresh(),
                .just(.setLoading(false))
            ])
            
        case .refreshEmotion:
            return Observable.concat([
                .just(.setLoading(true)),
                refreshEmotions(),
                .just(.setLoading(false))
            ])
            
        case .refreshMemory:
            return Observable.concat([
                .just(.setLoading(true)),
                refreshMemories(),
                .just(.setLoading(false))
            ])
        case .recordDidTap:
            steps.accept(AppStep.recordIsRequired(Date()))
            return .empty()
            
        case .calendarDidTap:
            steps.accept(AppStep.calendarIsRequired)
            return .empty()
            
        case .memoryDidTap(let memoryID):
            steps.accept(AppStep.memoryDetailIsRequired(memoryID))
            return .empty()
        }
    }
    
    func reduce(state: HomeState, mutation: HomeMutation) -> HomeState {
        var newState = state
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .setMemories(let memories, let todos):
            let memoryViewModel = MemoryHomeViewModel(
                pastWeekViewModel: makeWeekViewModel(memories),
                todoViewModel: makeTodoViewModel(todos)
            )
            newState.memoryViewModel = memoryViewModel
            
        case .setEmotions(let emotions):
            let emotionViewModel = EmotionHomeViewModel(
                pastWeekViewModel: makeEmotionPastWeekViewModel(emotions),
                graphViewModel: makeEmotionGraphViewModel(emotions)
            )
            newState.emotionViewModel = emotionViewModel
        }
        
        return newState
    }
    
    private func refresh() -> Observable<HomeMutation> {
        return Observable.merge([
            refreshMemories(),
            refreshEmotions()
        ])
    }
    
    private func refreshMemories() -> Observable<HomeMutation> {
        return Observable.zip(
            useCase.fetchLastSevenDaysMemories().asObservable(),
            useCase.fetchCurrentWeekTodos().asObservable()
        ).map { Mutation.setMemories($0.0, $0.1) }
    }
    
    private func refreshEmotions() -> Observable<HomeMutation> {
        return useCase.fetchLastSevenDaysEmotions()
            .map { Mutation.setEmotions($0) }
            .asObservable()
    }
    
    // MARK: - Emotion
    
    private func makeEmotionPastWeekViewModel(_ emotions: [Emotion]) -> EmotionHomePastWeekViewModel {
        let goodScore = emotions.filter { $0.emotionType == .good }.count
        let sosoScore = emotions.filter { $0.emotionType == .soso }.count
        let badScore = emotions.filter { $0.emotionType == .bad }.count
        
        return .init(items: [
            .init(score: goodScore, emotion: "좋아요"),
            .init(score: sosoScore, emotion: "그냥 그래요"),
            .init(score: badScore, emotion: "나빠요")
        ])
    }
    
    private func makeEmotionGraphViewModel(_ emotions: [Emotion]) -> EmotionHomeGraphViewModel {
        let items = (0..<7).map { Date().daysAgo(value: $0).day }.reversed()
            .map { day -> EmotionHomeGraphBarViewModel in
                let filteredEmotions = emotions.filter { $0.date.day == day }
                let goodScore = filteredEmotions.filter { $0.emotionType == .good }.count
                let sosoScore = filteredEmotions.filter { $0.emotionType == .soso }.count
                let badScore = filteredEmotions.filter { $0.emotionType == .bad }.count
                let sum = goodScore + sosoScore + badScore
                let rate = sum == 0 ? 0.0 : CGFloat(goodScore - badScore) / CGFloat(sum)
                return .init(rate: rate, date: "\(day)일")
            }
        return .init(items: items)
    }
    
    // MARK: - Memory
    
    private func makeWeekViewModel(_ memories: [Memory]) -> MemoryHomePastWeekViewModel {
        let items: [MemoryHomePastWeekContentViewModel] = memories.prefix(10).map {
            .init(id: $0.id, title: $0.note, imageData: $0.images.first)
        }
        return .init(items: items)
    }
    
    private func makeTodoViewModel(_ todos: [Todo]) -> MemoryHomeTodoViewModel {
        let items: [MemoryHomeTodoContentViewModel] = todos.prefix(10).map {
            .init(todo: $0.note, isChecked: $0.isCompleted)
        }
        return .init(items: items)
    }
    
}
