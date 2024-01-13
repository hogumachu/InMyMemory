//
//  MemoryDetailUseCase.swift
//
//
//  Created by 홍성준 on 1/13/24.
//

import Foundation
import Entities
import Interfaces
import CoreKit
import RxSwift

public final class MemoryDetailUseCase: MemoryDetailUseCaseInterface {
    
    private let memoryRepository: MemoryRepositoryInterface
    
    public init(memoryRepository: MemoryRepositoryInterface) {
        self.memoryRepository = memoryRepository
    }
    
    public func memory(id: UUID) -> Single<Memory?> {
        return memoryRepository.read(memoryID: id)
    }
    
}
