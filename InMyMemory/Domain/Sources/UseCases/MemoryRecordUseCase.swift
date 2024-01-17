//
//  MemoryRecordUseCase.swift
//
//
//  Created by 홍성준 on 1/13/24.
//

import Foundation
import Entities
import Interfaces
import CoreKit
import RxSwift

public final class MemoryRecordUseCase: MemoryRecordUseCaseInterface {
    
    private let memoryRepository: MemoryRepositoryInterface
    
    public init(memoryRepository: MemoryRepositoryInterface) {
        self.memoryRepository = memoryRepository
    }
    
    public func createMemory(_ memory: Memory) -> Single<Void> {
        return memoryRepository.update(memory: memory)
    }
    
}
