//
//  MemoryRecordUseCaseTests.swift
//  
//
//  Created by 홍성준 on 1/19/24.
//

@testable import UseCases
import Entities
import DomainTestSupport
import XCTest
import Quick
import Nimble

final class MemoryRecordUseCaseTests: QuickSpec {
    
    override class func spec() {
        var sut: MemoryRecordUseCase!
        var repository: MemoryRepositoryMock!
        var memory: Memory!
        
        describe("MemoryRecordUseCase 테스트") {
            beforeEach {
                repository = .init()
                sut = .init(memoryRepository: repository)
                memory = .init(id: .init(), images: [], note: "", date: .init())
            }
            
            context("createMemory를 호출하면") {
                beforeEach {
                    _ = sut.createMemory(memory)
                }
                
                it("MemoryRepository의 update(memory: Memory)가 호출된다") {
                    expect(repository.updateMemoryCallCount) == 1
                    expect(repository.updateMemoryMemory?.id) == memory.id
                }
            }
        }
    }
    
}
