//
//  HomeReactorTests.swift
//
//
//  Created by 홍성준 on 1/19/24.
//

@testable import HomePresentation
import PresentationTestSupport
import HomeTestSupport
import Entities
import Interfaces
import CoreKit
import BasePresentation
import XCTest
import Quick
import Nimble
import ReactorKit
import RxSwift
import RxRelay
import RxFlow

final class HomeReactorTests: QuickSpec {
    
    override class func spec() {
        var sut: HomeReactor!
        var useCase: HomeUseCaesMock!
        var disposeBag: DisposeBag!
        var stepBinder: StepBinder!
        
        describe("HomeReactor 테스트") {
            beforeEach {
                useCase = .init()
                disposeBag = .init()
                stepBinder = .init()
                sut = .init(useCase: useCase)
                sut.steps
                    .bind(to: stepBinder.step)
                    .disposed(by: disposeBag)
            }
            
            context("refresh가 호출되면") {
                let todos: [Todo] = [
                    .init(id: UUID(), note: "", isCompleted: false, date: Date()),
                    .init(id: UUID(), note: "", isCompleted: false, date: Date()),
                    .init(id: UUID(), note: "", isCompleted: false, date: Date()),
                    .init(id: UUID(), note: "", isCompleted: false, date: Date())
                ]
                let memories: [Memory] = [
                    .init(id: UUID(), images: [], note: "", date: Date()),
                    .init(id: UUID(), images: [], note: "", date: Date()),
                    .init(id: UUID(), images: [], note: "", date: Date()),
                    .init(id: UUID(), images: [], note: "", date: Date()),
                    .init(id: UUID(), images: [], note: "", date: Date())
                ]
                let emotions: [Emotion] = [
                    .init(id: UUID(), note: "", emotionType: .bad, date: Date()),
                    .init(id: UUID(), note: "", emotionType: .bad, date: Date()),
                    .init(id: UUID(), note: "", emotionType: .bad, date: Date()),
                    .init(id: UUID(), note: "", emotionType: .bad, date: Date()),
                    .init(id: UUID(), note: "", emotionType: .good, date: Date()),
                    .init(id: UUID(), note: "", emotionType: .soso, date: Date()),
                ]
                beforeEach {
                    useCase.fetchCurrentWeekTodosTodos = todos
                    useCase.fetchLastSevenDaysMemoriesMemories = memories
                    useCase.fetchLastSevenDaysEmotionsEmotions = emotions
                    sut.action.onNext(.refresh)
                }
                
                it("Todo 정보를 불러온다") {
                    expect(useCase.fetchCurrentWeekTodosCallCount) == 1
                }
                
                it("Emotion 정보를 불러온다") {
                    expect(useCase.fetchLastSevenDaysEmotionsCallCount) == 1
                }
                
                it("Memory 정보를 불러온다") {
                    expect(useCase.fetchLastSevenDaysMemoriesCallCount) == 1
                }
                
                it("TodoViewModel이 설정된다") {
                    let viewModel = try unwrap(sut.currentState.todoViewModel)
                    expect(viewModel.items.map(\.id)) == todos.map(\.id)
                }
                
                it("MemoryPastWeekViewModel이 설정된다") {
                    let viewModel = try unwrap(sut.currentState.memoryPastWeekViewModel)
                    expect(viewModel.items.map(\.id)) == memories.map(\.id)
                }
                
                it("EmotionViewModel이 설정된다") {
                    expect(sut.currentState.emotionViewModel) != nil
                }
                
                context("Todo 정보가 있는 상태에서 todoDidTap이 호출되면") {
                    beforeEach {
                        useCase.fetchCurrentWeekTodosCallCount = 0
                        let id = try unwrap(todos.first?.id)
                        sut.action.onNext(.todoDidTap(id))
                    }
                    
                    it("Todo 업데이트를 호출한다") {
                        expect(useCase.updateTodotodoCallCount) == 1
                    }
                    
                    it("Todo 정보를 불러온다") {
                        expect(useCase.fetchCurrentWeekTodosCallCount) == 1
                    }
                }
            }
            
            context("refreshEmotion이 호출되면") {
                let emotions: [Emotion] = [
                    .init(id: UUID(), note: "", emotionType: .bad, date: Date()),
                    .init(id: UUID(), note: "", emotionType: .bad, date: Date()),
                    .init(id: UUID(), note: "", emotionType: .bad, date: Date()),
                    .init(id: UUID(), note: "", emotionType: .bad, date: Date()),
                    .init(id: UUID(), note: "", emotionType: .good, date: Date()),
                    .init(id: UUID(), note: "", emotionType: .soso, date: Date()),
                ]
                
                beforeEach {
                    useCase.fetchLastSevenDaysEmotionsEmotions = emotions
                    sut.action.onNext(.refreshEmotion)
                }
                
                it("Emotion 정보를 불러온다") {
                    expect(useCase.fetchLastSevenDaysEmotionsCallCount) == 1
                }
                
                it("EmotionViewModel이 설정된다") {
                    expect(sut.currentState.emotionViewModel) != nil
                }
                
                it("Todo 정보를 불러오지 않는다") {
                    expect(useCase.fetchCurrentWeekTodosCallCount) == 0
                    expect(sut.currentState.todoViewModel) == nil
                }
                
                it("Memory 정보를 불러오지 않는다") {
                    expect(useCase.fetchLastSevenDaysMemoriesCallCount) == 0
                    expect(sut.currentState.memoryPastWeekViewModel) == nil
                }
            }
            
            context("refreshMemory이 호출되면") {
                let memories: [Memory] = [
                    .init(id: UUID(), images: [], note: "", date: Date()),
                    .init(id: UUID(), images: [], note: "", date: Date()),
                    .init(id: UUID(), images: [], note: "", date: Date()),
                    .init(id: UUID(), images: [], note: "", date: Date()),
                    .init(id: UUID(), images: [], note: "", date: Date())
                ]
                beforeEach {
                    useCase.fetchLastSevenDaysMemoriesMemories = memories
                    sut.action.onNext(.refreshMemory)
                }
                
                it("Memory 정보를 불러온다") {
                    expect(useCase.fetchLastSevenDaysMemoriesCallCount) == 1
                }
                
                it("MemoryPastWeekViewModel이 설정된다") {
                    let viewModel = try unwrap(sut.currentState.memoryPastWeekViewModel)
                    expect(viewModel.items.map(\.id)) == memories.map(\.id)
                }
                
                it("Emotion 정보를 불러오지 않는다") {
                    expect(useCase.fetchLastSevenDaysEmotionsCallCount) == 0
                    expect(sut.currentState.emotionViewModel) == nil
                }
                
                it("Todo 정보를 불러오지 않는다") {
                    expect(useCase.fetchCurrentWeekTodosCallCount) == 0
                    expect(sut.currentState.todoViewModel) == nil
                }
            }
            
            context("recordDidTap이 호출되면") {
                beforeEach {
                    sut.action.onNext(.recordDidTap)
                }
                
                it("recordIsRequired로 라우팅 된다.") {
                    expect {
                        let step = try unwrap(stepBinder.steps.last as? AppStep)
                        guard case .recordIsRequired = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return .succeeded
                    }.to(succeed())
                }
            }
            
            context("memoryRecordDidTap이 호출되면") {
                beforeEach {
                    sut.action.onNext(.memoryRecordDidTap)
                }
                
                it("memoryRecordIsRequired로 라우팅 된다.") {
                    expect {
                        let step = try unwrap(stepBinder.steps.last as? AppStep)
                        guard case .memoryRecordIsRequired = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return .succeeded
                    }.to(succeed())
                }
            }
            
            context("emotionRecordDidTap이 호출되면") {
                beforeEach {
                    sut.action.onNext(.emotionRecordDidTap)
                }
                
                it("emotionRecordIsRequired로 라우팅 된다.") {
                    expect {
                        let step = try unwrap(stepBinder.steps.last as? AppStep)
                        guard case .emotionRecordIsRequired = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return .succeeded
                    }.to(succeed())
                }
            }
            
            context("calendarDidTap이 호출되면") {
                beforeEach {
                    sut.action.onNext(.calendarDidTap)
                }
                
                it("calendarIsRequired로 라우팅 된다.") {
                    expect {
                        let step = try unwrap(stepBinder.steps.last as? AppStep)
                        guard case .calendarIsRequired = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return .succeeded
                    }.to(succeed())
                }
            }
            
            context("memoryDidTap이 호출되면") {
                let id = UUID()
                beforeEach {
                    sut.action.onNext(.memoryDidTap(id))
                }
                
                it("memoryDetailIsRequired로 라우팅 된다.") {
                    expect {
                        let step = try unwrap(stepBinder.steps.last as? AppStep)
                        guard case .memoryDetailIsRequired(let memoryID) = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return memoryID == id ? .succeeded : .failed(reason: "올바르지 않은 ID")
                    }.to(succeed())
                }
            }
            
            context("Todo 정보가 없는 상태에서 todoDidTap이 호출되면") {
                let id = UUID()
                beforeEach {
                    sut.action.onNext(.todoDidTap(id))
                }
                
                it("Todo 업데이트를 호출하지 않는다") {
                    expect(useCase.updateTodotodoCallCount) == 0
                }
                
                it("Todo 정보를 불러온다") {
                    expect(useCase.fetchCurrentWeekTodosCallCount) == 1
                }
            }
        }
    }
    
}
