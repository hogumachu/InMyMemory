//
//  MemoryRecordUseCaseMock.swift
//
//
//  Created by 홍성준 on 1/18/24.
//

import Interfaces
import Entities
import RxSwift

public final class MemoryRecordUseCaseMock: MemoryRecordUseCaseInterface {
    
    public init() {}
    
    public var createMemoryMemoryCallCount = 0
    public var createMemoryMemoryMemory: Memory?
    public func createMemory(_ memory: Memory) -> Single<Void> {
        createMemoryMemoryCallCount += 1
        createMemoryMemoryMemory = memory
        return .just(())
    }
    
}
