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

final class MemoryRepositoryMock: MemoryRepositoryInterface {
    
    init() {}
    
    var createMemoryCallCount = 0
    var createMemoryMemory: Memory?
    func create(memory: Memory) -> Single<Void> {
        createMemoryCallCount += 1
        createMemoryMemory = memory
        return .just(())
    }
    
    var readMemoryIDCallCount = 0
    var readMemoryIDMemoryID: UUID?
    var readMemoryIDMemory: Memory?
    func read(memoryID: UUID) -> Single<Memory?>{
        readMemoryIDCallCount += 1
        readMemoryIDMemoryID = memoryID
        return .just(readMemoryIDMemory)
    }
    
    var readGreaterThanCallCount = 0
    var readGreaterThanDate: Date?
    var readGreaterThanMemories: [Memory] = []
    func read(greaterThan date: Date) -> Single<[Memory]> {
        readGreaterThanCallCount += 1
        readGreaterThanDate = date
        return .just(readGreaterThanMemories)
    }
    
    var readGreaterOrEqualThanLessThanCallCount = 0
    var readGreaterOrEqualThanLessThanGreaterOrEqualDate: Date?
    var readGreaterOrEqualThanLessThanLessDate: Date?
    var readGreaterOrEqualThanLessThanMemories: [Memory] = []
    func read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date) -> Single<[Memory]> {
        readGreaterOrEqualThanLessThanCallCount += 1
        readGreaterOrEqualThanLessThanGreaterOrEqualDate = greaterOrEqualDate
        readGreaterOrEqualThanLessThanLessDate = lessDate
        return .just(readGreaterOrEqualThanLessThanMemories)
    }
    
    var readKeywordCallCount = 0
    var readKeywordKeyword: String?
    var readKeywordMemories: [Memory] = []
    func read(keyword: String) -> Single<[Memory]> {
        readKeywordCallCount += 1
        readKeywordKeyword = keyword
        return .just(readKeywordMemories)
    }
    
    var updateMemoryCallCount = 0
    var updateMemoryMemory: Memory?
    func update(memory: Memory) -> Single<Void> {
        updateMemoryCallCount += 1
        updateMemoryMemory = memory
        return .just(())
    }
    
    var deleteMemoryCallCount = 0
    var deleteMemoryMemory: Memory?
    func delete(memory: Memory) -> Single<Void> {
        deleteMemoryCallCount += 1
        deleteMemoryMemory = memory
        return .just(())
    }
    
    var deleteMemoryIDCallCount = 0
    var deleteMemoryIDMemoryID: UUID?
    func delete(memoryID: UUID) -> Single<Void> {
        deleteMemoryIDCallCount += 1
        deleteMemoryIDMemoryID = memoryID
        return .just(())
    }
    
}
