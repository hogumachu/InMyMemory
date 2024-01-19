//
//  SearchUseCaseTests.swift
//
//
//  Created by 홍성준 on 1/19/24.
//

@testable import UseCases
import Entities
import XCTest
import Quick
import Nimble

final class SearchUseCaseTests: QuickSpec {
    
    override class func spec() {
        var sut: SearchUseCase!
        var emotionRepository: EmotionRepositoryMock!
        var memoryRepository: MemoryRepositoryMock!
        var todoRepository: TodoRepositoryMock!
        
        describe("SearchUseCase 테스트") {
            beforeEach {
                emotionRepository = .init()
                memoryRepository = .init()
                todoRepository = .init()
                sut = .init(
                    emotionRepository: emotionRepository,
                    memoryRepository: memoryRepository,
                    todoRepository: todoRepository
                )
            }
            
            context("fetchMemories가 호출되면") {
                let keyword = "Test fetchMemories"
                beforeEach {
                    _ = sut.fetchMemories(keyword: keyword)
                }
                
                it("MemoryRepository의 read(keyword: String)이 호출된다") {
                    expect { memoryRepository.readKeywordCallCount } == 1
                    expect { memoryRepository.readKeywordKeyword } == keyword
                }
            }
            
            context("fetchTodos가 호출되면") {
                let keyword = "Test fetchTodos"
                beforeEach {
                    _ = sut.fetchTodos(keyword: keyword)
                }
                
                it("TodoRepository의 read(keyword: String)이 호출된다") {
                    expect { todoRepository.readKeywordCallCount } == 1
                    expect { todoRepository.readKeywordKeyword } == keyword
                }
            }
            
            context("fetchEmotions가 호출되면") {
                let keyword = "Test fetchEmotions"
                beforeEach {
                    _ = sut.fetchEmotions(keyword: keyword)
                }
                
                it("EmotionRepository의 read(keyword: String)이 호출된다") {
                    expect { emotionRepository.readKeywordCallCount } == 1
                    expect { emotionRepository.readKeywordKeyword } == keyword
                }
            }
        }
    }
    
}
