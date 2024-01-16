//
//  UseCaseAssembly.swift
//
//
//  Created by 홍성준 on 1/6/24.
//

import Foundation
import CoreKit
import Interfaces
import Swinject

public struct UseCaseAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        let emotionRepository = container.resolve(EmotionRepositoryInterface.self)!
        let memoryRepository = container.resolve(MemoryRepositoryInterface.self)!
        let todoRepository = container.resolve(TodoRepositoryInterface.self)!
        
        container.register(HomeUseCaseInterface.self) { _ in
            HomeUseCase(
                emotionRepository: emotionRepository,
                memoryRepository: memoryRepository,
                todoRepository: todoRepository
            )
        }
        
        container.register(EmotionRecordUseCaseInterface.self) { _ in
            EmotionRecordUseCase(emotionRepository: emotionRepository)
        }
        
        container.register(CalendarUseCaseInterface.self) { _ in
            CalendarUseCase(
                emotionRepository: emotionRepository,
                memoryRepository: memoryRepository,
                todoRepository: todoRepository
            )
        }
        
        container.register(MemoryRecordUseCaseInterface.self) { _ in
            MemoryRecordUseCase(memoryRepository: memoryRepository)
        }
        
        container.register(MemoryDetailUseCaseInterface.self) { _ in
            MemoryDetailUseCase(memoryRepository: memoryRepository)
        }
        
        container.register(SearchUseCaseInterface.self) { _ in
            SearchUseCase(
                emotionRepository: emotionRepository,
                memoryRepository: memoryRepository,
                todoRepository: todoRepository
            )
        }
    }
    
}
