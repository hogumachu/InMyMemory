//
//  HomeUseCaseTests.swift
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

final class HomeUseCaseTests: QuickSpec {
    
    override class func spec() {
        var sut: HomeUseCase!
        var emotionRepository: EmotionRepositoryMock!
        var memoryRepository: MemoryRepositoryMock!
        var todoRepository: TodoRepositoryMock!
        
        describe("HomeUseCase 테스트") {
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
            
            context("fetchLastSevenDaysMemories를 호출하면") {
                beforeEach {
                    _ = sut.fetchLastSevenDaysMemories()
                }
                
                it("7일 이전의 데이터를 불러온다") {
                    let date = try unwrap(memoryRepository.readGreaterThanDate)
                    let sevenDaysAgo = Date().daysAgo(value: 7)
                    expect(date.year) == sevenDaysAgo.year
                    expect(date.month) == sevenDaysAgo.month
                    expect(date.day) == sevenDaysAgo.day
                }
            }
            
            context("fetchCurrentWeekTodos를 호출하면") {
                beforeEach {
                    _ = sut.fetchCurrentWeekTodos()
                }
                
                it("7일 이전 그리고 7일 이후 사이의 데이터를 불러온다") {
                    let greaterOrEqaulData = try unwrap(todoRepository.readGreaterOrEqualThanLessThanGreaterOrEqualDate)
                    let lessDate = try unwrap(todoRepository.readGreaterOrEqualThanLessThanLessDate)
                    let sevenDaysAgo = Date().daysAgo(value: 7)
                    let sevenDaysAfter = Date().daysAgo(value: -7)
                    expect(greaterOrEqaulData.year) == sevenDaysAgo.year
                    expect(greaterOrEqaulData.month) == sevenDaysAgo.month
                    expect(greaterOrEqaulData.day) == sevenDaysAgo.day
                    
                    expect(lessDate.year) == sevenDaysAfter.year
                    expect(lessDate.month) == sevenDaysAfter.month
                    expect(lessDate.day) == sevenDaysAfter.day
                }
            }
            
            context("fetchLastSevenDaysEmotions를 호출하면") {
                beforeEach {
                    _ = sut.fetchLastSevenDaysEmotions()
                }
                
                it("7일 이전의 데이터를 불러온다") {
                    let date = try unwrap(emotionRepository.readGreaterThanDate)
                    let sevenDaysAgo = Date().daysAgo(value: 7)
                    expect(date.year) == sevenDaysAgo.year
                    expect(date.month) == sevenDaysAgo.month
                    expect(date.day) == sevenDaysAgo.day
                }
            }
            
            context("updateTodo를 호출하면") {
                var todo: Todo!
                beforeEach {
                    todo = .init(id: .init(), note: "", isCompleted: true, date: .init())
                    _ = sut.updateTodo(todo: todo)
                }
                
                it("TodoRepository의 UpdateTodo를 호출한다") {
                    expect(todoRepository.updateTodoCallCount) == 1
                    expect(todoRepository.updateTodoTodo?.id) == todo.id
                }
            }
        }
    }
    
}
