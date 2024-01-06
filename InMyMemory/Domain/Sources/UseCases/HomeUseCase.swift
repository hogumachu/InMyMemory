//
//  HomeUseCase.swift
//
//
//  Created by 홍성준 on 1/6/24.
//

import Foundation
import Interfaces

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
    
}
