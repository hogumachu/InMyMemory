//
//  MemoryRepositoryMock.swift
//
//
//  Created by 홍성준 on 1/19/24.
//

import Foundation
import Interfaces
import Entities
import RxSwift

public final class MemoryRepositoryMock: MemoryRepositoryInterface {
    
    public init() {}
    
    public var createMemoryCallCount = 0
    public var createMemoryMemory: Memory?
    public func create(memory: Memory) -> Single<Void> {
        createMemoryCallCount += 1
        createMemoryMemory = memory
        return .just(())
    }
    
    public var readMemoryIDCallCount = 0
    public var readMemoryIDMemoryID: UUID?
    public var readMemoryIDMemory: Memory?
    public func read(memoryID: UUID) -> Single<Memory?>{
        readMemoryIDCallCount += 1
        readMemoryIDMemoryID = memoryID
        return .just(readMemoryIDMemory)
    }
    
    public var readGreaterThanCallCount = 0
    public var readGreaterThanDate: Date?
    public var readGreaterThanMemories: [Memory] = []
    public func read(greaterThan date: Date) -> Single<[Memory]> {
        readGreaterThanCallCount += 1
        readGreaterThanDate = date
        return .just(readGreaterThanMemories)
    }
    
    public var readGreaterOrEqualThanLessThanCallCount = 0
    public var readGreaterOrEqualThanLessThanGreaterOrEqualDate: Date?
    public var readGreaterOrEqualThanLessThanLessDate: Date?
    public var readGreaterOrEqualThanLessThanMemories: [Memory] = []
    public func read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date) -> Single<[Memory]> {
        readGreaterOrEqualThanLessThanCallCount += 1
        readGreaterOrEqualThanLessThanGreaterOrEqualDate = greaterOrEqualDate
        readGreaterOrEqualThanLessThanLessDate = lessDate
        return .just(readGreaterOrEqualThanLessThanMemories)
    }
    
    public var readKeywordCallCount = 0
    public var readKeywordKeyword: String?
    public var readKeywordMemories: [Memory] = []
    public func read(keyword: String) -> Single<[Memory]> {
        readKeywordCallCount += 1
        readKeywordKeyword = keyword
        return .just(readKeywordMemories)
    }
    
    public var updateMemoryCallCount = 0
    public var updateMemoryMemory: Memory?
    public func update(memory: Memory) -> Single<Void> {
        updateMemoryCallCount += 1
        updateMemoryMemory = memory
        return .just(())
    }
    
    public var deleteMemoryCallCount = 0
    public var deleteMemoryMemory: Memory?
    public func delete(memory: Memory) -> Single<Void> {
        deleteMemoryCallCount += 1
        deleteMemoryMemory = memory
        return .just(())
    }
    
    public var deleteMemoryIDCallCount = 0
    public var deleteMemoryIDMemoryID: UUID?
    public func delete(memoryID: UUID) -> Single<Void> {
        deleteMemoryIDCallCount += 1
        deleteMemoryIDMemoryID = memoryID
        return .just(())
    }
    
}
