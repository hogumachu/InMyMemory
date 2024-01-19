//
//  MemoryDetailUseCaseTests.swift
//
//
//  Created by 홍성준 on 1/19/24.
//

@testable import UseCases
import Entities
import XCTest
import Quick
import Nimble

final class MemoryDetailUseCaseTests: QuickSpec {
    
    override class func spec() {
        var sut: MemoryDetailUseCase!
        var repository: MemoryRepositoryMock!
        var memoryID: UUID!
        
        describe("MemoryDetailUseCase 테스트") {
            beforeEach {
                memoryID = .init()
                repository = .init()
                sut = .init(memoryRepository: repository)
            }
            
            context("memory를 호출하면") {
                beforeEach {
                    _ = sut.memory(id: memoryID)
                }
                
                it("MemoryRepository의 memory(id: UUID)가 호출된다") {
                    expect(repository.readMemoryIDCallCount) == 1
                    expect(repository.readMemoryIDMemoryID) == memoryID
                }
            }
            
            context("remove를 호출하면") {
                beforeEach {
                    _ = sut.remove(memoryID: memoryID)
                }
                
                it("memoryRepository의 delete(memoryID: UUID)가 호출된다") {
                    expect(repository.deleteMemoryIDCallCount) == 1
                    expect(repository.deleteMemoryIDMemoryID) == memoryID
                }
            }
        }
    }
    
}
