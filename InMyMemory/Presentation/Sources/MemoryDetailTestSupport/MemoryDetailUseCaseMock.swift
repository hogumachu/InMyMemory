//
//  MemoryDetailUseCaseMock.swift
//
//
//  Created by 홍성준 on 1/18/24.
//

import Foundation
import Interfaces
import Entities
import RxSwift

public final class MemoryDetailUseCaseMock: MemoryDetailUseCaseInterface {
    
    public init() {}
    
    public var memoryidCallCount = 0
    public var memoryidid: UUID?
    public var memoryidMemory: Memory?
    public func memory(id: UUID) -> Single<Memory?> {
        memoryidCallCount += 1
        memoryidid = id
        return .just(memoryidMemory)
    }
    
    public var removememoryIDCallCount = 0
    public var removememoryIDmemoryID: UUID?
    public func remove(memoryID: UUID) -> Single<Void> {
        removememoryIDCallCount += 1
        removememoryIDmemoryID = memoryID
        return .just(())
    }
    
}
