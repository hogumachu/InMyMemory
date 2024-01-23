//
//  TodoUseCaseTests.swift
//
//
//  Created by 홍성준 on 1/23/24.
//

@testable import UseCases
import Entities
import DomainTestSupport
import XCTest
import Quick
import Nimble

final class TodoUseCaseTests: AsyncSpec {
    
    override class func spec() {
        var sut: TodoUseCase!
        var repository: TodoRepositoryMock!
        
        describe("TodoUseCase 테스트") {
            beforeEach {
                repository = .init()
                sut = .init(todoRepository: repository)
            }
            
            context("fetchMemories가 호출되면") {
                beforeEach {
                    _ = try await sut.fetchDaysInMonth(year: 2024, month: 1).value
                }
                
                it("MemoryRepository에 아무 것도 호출하지 않는다") {
                    expect { repository.readGreaterOrEqualThanLessThanCallCount } == 0
                    expect { repository.readKeywordCallCount } == 0
                }
            }
            
            context("2024년 1월 값을 읽어오면") {
                var days: [Day]!
                beforeEach {
                    days = try await sut.fetchDaysInMonth(year: 2024, month: 1).value
                }
                
                it("1일부터 31일의 데이터가 존재한다.") {
                    let filtered = days.filter { $0.metadata.isValid }
                    expect { filtered.count } == 31
                    expect { filtered.map(\.metadata.number).sorted() } == (1...31).map { $0 }
                }
            }
            
            context("2024년 2월 값을 읽어오면") {
                var days: [Day]!
                beforeEach {
                    days = try await sut.fetchDaysInMonth(year: 2024, month: 2).value
                }
                
                it("1일부터 29일의 데이터가 존재한다.") {
                    let filtered = days.filter { $0.metadata.isValid }
                    expect { filtered.count } == 29
                    expect { filtered.map(\.metadata.number).sorted() } == (1...29).map { $0 }
                }
            }
            
            describe("Repository에 Todo 값이 주어지고") {
                let date = Date()
                beforeEach {
                    repository.readGreaterOrEqualThanLessThanTodos = [
                        .init(id: .init(), note: "Todo", isCompleted: true, date: date)
                    ]
                }
                
                context("해당 날짜의 데이터를 불러오면") {
                    var days: [Day]!
                    
                    beforeEach {
                        days = try await sut.fetchDaysInMonth(year: date.year, month: date.month).value
                    }
                    
                    it("해당 날짜에 item은 비어있다.") {
                        let day = try unwrap(days.filter { $0.metadata.isValid && $0.metadata.number == date.day }.first)
                        expect { day.items.count } == 0
                    }
                }
            }
            
            context("createTodo가 호출되면") {
                let todo: Todo = .init(id: .init(), note: "Todo", isCompleted: true, date: .init())
                beforeEach {
                    _ = try await sut.createTodo(todo).value
                }
                
                it("Repository의 create(todo: Todo)가 호출된다") {
                    expect { repository.createTodoCallCount } == 1
                    expect { repository.createTodoTodo?.id } == todo.id
                }
            }
        }
    }
    
}
