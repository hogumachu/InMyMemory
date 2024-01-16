//
//  SearchUseCase.swift
//
//
//  Created by 홍성준 on 1/16/24.
//

import Foundation
import Entities
import Interfaces
import CoreKit
import RxSwift

public final class SearchUseCase: SearchUseCaseInterface {
    
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
    
    public func fetchMemories(keyword: String) -> Single<[Memory]> {
        return memoryRepository.read(keyword: keyword)
    }
    
    public func fetchTodos(keyword: String) -> Single<[Todo]> {
        return todoRepository.read(keyword: keyword)
        
    }
    
    public func fetchEmotions(keyword: String) -> Single<[Emotion]> {
        return emotionRepository.read(keyword: keyword)
    }
    
}
