//
//  MemoryDetailReactorTests.swift
//
//
//  Created by 홍성준 on 1/18/24.
//

@testable import MemoryDetailPresentation
import PresentationTestSupport
import MemoryDetailTestSupport
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

final class MemoryDetailReactorTests: QuickSpec {
    
    override class func spec() {
        var sut: MemoryDetailReactor!
        var useCase: MemoryDetailUseCaseMock!
        var stepBinder: StepBinder!
        var disposeBag: DisposeBag!
        var memoryID: UUID!
        var memory: Memory!
        
        describe("MemoryDetailReactor 테스트") {
            beforeEach {
                memoryID = .init()
                memory = .init(id: memoryID, images: [Data()], note: "Test 123123123", date: .init())
                useCase = .init()
                useCase.memoryidMemory = memory
                stepBinder = .init()
                disposeBag = .init()
                sut = .init(memoryID: memoryID, useCase: useCase)
                sut.steps
                    .bind(to: stepBinder.step)
                    .disposed(by: disposeBag)
            }
            
            context("새로고침이 호출되면") {
                beforeEach {
                    sut.action.onNext(.refresh)
                }
                
                it("MemoryID를 통해 Memory 정보를 불러온다") {
                    expect(sut.currentState.memory?.id) == useCase.memoryidMemory?.id
                    expect(useCase.memoryidCallCount) == 1
                }
                
                it("ViewModel이 생성된다") {
                    expect(sut.currentState.viewModel?.note) == useCase.memoryidMemory?.note
                    expect(sut.currentState.viewModel?.images) == useCase.memoryidMemory?.images
                }
                
                context("편집 버튼을 누르면") {
                    beforeEach {
                        sut.action.onNext(.editDidTap)
                    }
                    
                    it("memoryEditIsRequired로 라우팅 된다") {
                        let step = try unwrap(stepBinder.steps.last as? AppStep)
                        expect {
                            guard case .memoryEditIsRequired(let editMemory) = step else {
                                return .failed(reason: "올바르지 않은 라우팅")
                            }
                            return memory.id == editMemory.id ? .succeeded : .failed(reason: "올바르지 않은 Memory")
                        }.to(succeed())
                    }
                }
            }
            
            context("제거 버튼을 누르면") {
                beforeEach {
                    sut.action.onNext(.removeDidTap)
                }
                
                it("제거된다") {
                    expect(useCase.removememoryIDCallCount) == 1
                }
                
                it("memoryDetailIsComplete로 라우팅 된다") {
                    let step = try unwrap(stepBinder.steps.last as? AppStep)
                    expect {
                        guard case .memoryDetailIsComplete = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return .succeeded
                    }.to(succeed())
                }
            }
            
            context("Memory가 없는 상태에서 편집 버튼을 누르면") {
                beforeEach {
                    sut.isStubEnabled = true
                    sut.stub.state.value = .init(memory: nil)
                    sut.action.onNext(.editDidTap)
                }
                
                afterEach {
                    sut.isStubEnabled = false
                }
                
                it("아무런 동작을 하지 않는다") {
                    expect(stepBinder.steps.isEmpty) == true
                }
            }
        }
    }
    
}
