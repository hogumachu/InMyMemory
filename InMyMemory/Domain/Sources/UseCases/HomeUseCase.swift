//
//  HomeUseCase.swift
//
//
//  Created by 홍성준 on 1/6/24.
//

import Foundation
import Entities
import Interfaces
import CoreKit
import RxSwift

public final class HomeUseCase: HomeUseCaseInterface {
    
    private let emotionRepository: EmotionRepositoryInterface
    private let memoryRepository: MemoryRepositoryInterface
    private let todoRepository: TodoRepositoryInterface
    
    public init(
        emotionRepository: EmotionRepositoryInterface,
        memoryRepository: MemoryRepositoryInterface,
        todoRepository: TodoRepositoryInterface
    ) {
        self.emotionRepository = emotionRepository
        self.memoryRepository = memoryRepository
        self.todoRepository = todoRepository
    }
    
    public func fetchLastSevenDaysMemories() -> Single<[Memory]> {
        let sevenDaysAgo = Date().daysAgo(value: 7).clipDate()
        return memoryRepository.read(greaterThan: sevenDaysAgo)
    }
    
    public func fetchCurrentWeekTodos() -> Single<[Todo]> {
        let sevenDaysAgo = Date().daysAgo(value: 7).clipDate()
        return todoRepository.read(greaterThan: sevenDaysAgo)
    }
    
    public func fetchLastSevenDaysEmotions() -> Single<[Emotion]> {
        let sevenDaysAgo = Date().daysAgo(value: 7).clipDate()
        return emotionRepository.read(greaterThan: sevenDaysAgo)
    }
    
}
