//
//  CalendarUseCaseTests.swift
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

final class CalendarUseCaseTests: AsyncSpec {
    
    override class func spec() {
        var sut: CalendarUseCase!
        var emotionRepository: EmotionRepositoryMock!
        var memoryRepository: MemoryRepositoryMock!
        var todoRepository: TodoRepositoryMock!
        
        describe("CalendarUseCase 테스트") {
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
            
            context("fetchDaysInMonth를 호출하면") {
                beforeEach {
                    _ = try await sut.fetchDaysInMonth(year: 2024, month: 1).value
                }
                
                it("EmotionRepository의 read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date)가 호출된다") {
                    expect { emotionRepository.readGreaterOrEqualThanLessThanCallCount } == 1
                }
                
                it("MemoryRepository의 read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date)가 호출된다") {
                    expect { memoryRepository.readGreaterOrEqualThanLessThanCallCount } == 1
                }
                
                it("TodoRepository의 read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date)가 호출된다") {
                    expect { todoRepository.readGreaterOrEqualThanLessThanCallCount } == 1
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
            
            describe("Repository에 Emotion, Memory, Todo 값이 주어지고") {
                let date = Date()
                beforeEach {
                    emotionRepository.readGreaterOrEqualThanLessThanEmotions = [
                        .init(id: .init(), note: "Emotion", emotionType: .good, date: date)
                    ]
                    memoryRepository.readGreaterOrEqualThanLessThanMemories = [
                        .init(id: .init(), images: [], note: "Memory", date: date)
                    ]
                    todoRepository.readGreaterOrEqualThanLessThanTodos = [
                        .init(id: .init(), note: "Todo", isCompleted: true, date: date)
                    ]
                }
                
                context("해당 날짜의 데이터를 불러오면") {
                    var days: [Day]!
                    
                    beforeEach {
                        days = try await sut.fetchDaysInMonth(year: date.year, month: date.month).value
                    }
                    
                    it("해당 날짜에 Emotion 값이 존재한다") {
                        let day = try unwrap(days.filter { $0.metadata.isValid && $0.metadata.number == date.day }.first)
                        expect { day.items.contains(where: {
                            switch $0 {
                            case .emotion:
                                return true
                            default:
                                return false
                            }
                        })} == true
                    }
                    
                    it("해당 날짜에 Memory 값이 존재한다") {
                        let day = try unwrap(days.filter { $0.metadata.isValid && $0.metadata.number == date.day }.first)
                        expect { day.items.contains(where: {
                            switch $0 {
                            case .memory:
                                return true
                            default:
                                return false
                            }
                        })} == true
                    }
                    
                    it("해당 날짜에 Todo 값이 존재한다") {
                        let day = try unwrap(days.filter { $0.metadata.isValid && $0.metadata.number == date.day }.first)
                        expect { day.items.contains(where: {
                            switch $0 {
                            case .todo:
                                return true
                            default:
                                return false
                            }
                        })} == true
                    }
                }
            }
        }
    }
    
}
