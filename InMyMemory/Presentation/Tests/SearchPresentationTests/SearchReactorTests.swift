//
//  SearchReactorTests.swift
//
//
//  Created by 홍성준 on 1/23/24.
//

@testable import SearchPresentation
import PresentationTestSupport
import DomainTestSupport
import Entities
import Interfaces
import UseCases
import CoreKit
import BasePresentation
import XCTest
import Quick
import Nimble
import ReactorKit
import RxSwift
import RxRelay
import RxFlow

final class SearchReactorTests: QuickSpec {
    
    override class func spec() {
        var sut: SearchReactor!
        var useCase: SearchUseCaseInterface!
        var emotionRepository: EmotionRepositoryMock!
        var memoryRepository: MemoryRepositoryMock!
        var todoRepository: TodoRepositoryMock!
        var stepBinder: StepBinder!
        var disposeBag: DisposeBag!
        
        describe("SearchReactor 테스트") {
            beforeEach {
                emotionRepository = .init()
                memoryRepository = .init()
                todoRepository = .init()
                useCase = SearchUseCase(
                    emotionRepository: emotionRepository,
                    memoryRepository: memoryRepository,
                    todoRepository: todoRepository
                )
                stepBinder = .init()
                disposeBag = .init()
                sut = .init(useCase: useCase)
                sut.steps
                    .bind(to: stepBinder.step)
                    .disposed(by: disposeBag)
            }
            
            context("updateKeyword가 호출되면") {
                let keyword = "Test Keyword"
                beforeEach {
                    sut.action.onNext(.updateKeyword(keyword))
                }
                
                it("Keyword 상태 값이 변경된다") {
                    expect(sut.currentState.keyword) == keyword
                }
            }
            
            describe("nil인 문자가 입력되었을 때") {
                beforeEach {
                    sut.action.onNext(.updateKeyword(nil))
                }
                
                context("검색을 누르면") {
                    beforeEach {
                        sut.action.onNext(.search)
                    }
                    
                    it("검색을 호출하지 않는다") {
                        expect { memoryRepository.readKeywordCallCount } == 0
                        expect { emotionRepository.readKeywordCallCount } == 0
                        expect { todoRepository.readKeywordCallCount } == 0
                    }
                }
            }
            
            describe("값이 있는 문자가 입력되었을 때") {
                beforeEach {
                    sut.action.onNext(.updateKeyword("Test Keyword"))
                }
                
                context("검색을 누르면") {
                    beforeEach {
                        sut.action.onNext(.search)
                    }
                    
                    it("검색을 호출한다") {
                        expect { memoryRepository.readKeywordCallCount } == 1
                        expect { emotionRepository.readKeywordCallCount } == 1
                        expect { todoRepository.readKeywordCallCount } == 1
                    }
                }
            }
            
            describe("Section 테스트") {
                let memoryID: UUID = .init()
                let emotionID: UUID = .init()
                let todoID: UUID = .init()
                let memoryIndexPath: IndexPath = .init(row: 0, section: 0)
                let emotionIndexPath: IndexPath = .init(row: 0, section: 1)
                let todoIndexPath: IndexPath = .init(row: 0, section: 2)
                
                beforeEach {
                    memoryRepository.readKeywordMemories = [.init(id: memoryID, images: [], note: "Memory", date: .init())]
                    emotionRepository.readKeywordEmotions = [.init(id: emotionID, note: "Emotion", emotionType: .good, date: .init())]
                    todoRepository.readKeywordTodos = [.init(id: todoID, note: "Todo", isCompleted: true, date: .init())]
                    sut.action.onNext(.updateKeyword("Test Keyword"))
                    sut.action.onNext(.search)
                }
                
                it("Section은 Memory, Emotion, Todo 순으로 저장된다") {
                    expect {
                        guard case .memory(let model) = sut.currentState.sections[memoryIndexPath.section].items[memoryIndexPath.row] else {
                            return .failed(reason: "올바르지 않은 데이터 타입")
                        }
                        return model.id == memoryID ? .succeeded : .failed(reason: "올바르지 않은 ID")
                    }.to(succeed())
                    
                    expect {
                        guard case .emotion(let model) = sut.currentState.sections[emotionIndexPath.section].items[emotionIndexPath.row] else {
                            return .failed(reason: "올바르지 않은 데이터 타입")
                        }
                        return model.id == emotionID ? .succeeded : .failed(reason: "올바르지 않은 ID")
                    }.to(succeed())
                    
                    expect {
                        guard case .todo(let model) = sut.currentState.sections[todoIndexPath.section].items[todoIndexPath.row] else {
                            return .failed(reason: "올바르지 않은 데이터 타입")
                        }
                        return model.id == todoID ? .succeeded : .failed(reason: "올바르지 않은 ID")
                    }.to(succeed())
                }
                
                context("Memory 아이템이 선택되면") {
                    beforeEach {
                        sut.action.onNext(.itemDidTap(memoryIndexPath))
                    }
                    
                    it("memoryDetailIsRequired로 라우팅된다") {
                        let step = try unwrap(stepBinder.steps.last as? AppStep)
                        expect {
                            guard case .memoryDetailIsRequired(let id) = step else {
                                return .failed(reason: "올바르지 않은 라우팅")
                            }
                            return id == memoryID ? .succeeded : .failed(reason: "올바르지 않은 ID")
                        }.to(succeed())
                    }
                }
                
                context("Emotion 아이템이 선택되면") {
                    beforeEach {
                        stepBinder.steps = []
                        sut.action.onNext(.itemDidTap(emotionIndexPath))
                    }
                    
                    it("emotionDetailIsRequired로 라우팅된다") {
                        let step = try unwrap(stepBinder.steps.last as? AppStep)
                        expect {
                            guard case .emotionDetailIsRequired(let id) = step else {
                                return .failed(reason: "올바르지 않은 라우팅")
                            }
                            return id == emotionID ? .succeeded : .failed(reason: "올바르지 않은 ID")
                        }.to(succeed())
                    }
                }
                
                context("Todo 아이템이 선택되면") {
                    beforeEach {
                        stepBinder.steps = []
                        sut.action.onNext(.itemDidTap(todoIndexPath))
                    }
                    
                    it("라우팅이 호출되지 않는다") {
                        expect { stepBinder.steps.isEmpty } == true
                    }
                }
            }
            
            context("closeDidTap을 호출하면") {
                beforeEach {
                    sut.action.onNext(.closeDidTap)
                }
                
                it("searchIsComplete로 라우팅된다") {
                    let step = try unwrap(stepBinder.steps.last as? AppStep)
                    expect {
                        guard case .searchIsComplete = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return .succeeded
                    }.to(succeed())
                }
            }
        }
    }
    
}
