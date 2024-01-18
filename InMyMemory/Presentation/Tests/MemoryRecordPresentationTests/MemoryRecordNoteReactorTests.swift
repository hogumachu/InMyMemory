//
//  MemoryRecordNoteReactorTests.swift
//  
//
//  Created by 홍성준 on 1/18/24.
//

@testable import MemoryRecordPresentation
import PresentationTestSupport
import MemoryRecordTestSupport
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

final class MemoryRecordNoteReactorTests: QuickSpec {
    
    override class func spec() {
        var sut: MemoryRecordNoteReactor!
        var useCase: MemoryRecordUseCaseMock!
        var stepBinder: StepBinder!
        var disposeBag: DisposeBag!
        var images: [Data]!
        
        describe("MemoryRecordNoteReactor 테스트") {
            beforeEach {
                images = [Data(), Data()]
                useCase = .init()
                sut = .init(images: images, useCase: useCase)
                stepBinder = .init()
                disposeBag = .init()
                sut.steps
                    .bind(to: stepBinder.step)
                    .disposed(by: disposeBag)
            }
            
            context("빈 텍스트가 입력되면") {
                beforeEach {
                    sut.action.onNext(.textDidUpdated(""))
                }
                
                it("isEnabled 상태 값이 false가 된다") {
                    expect(sut.currentState.isEnabled) == false
                }
            }
            
            context("값이 있는 텍스트가 입력되면") {
                beforeEach {
                    sut.action.onNext(.textDidUpdated("Test"))
                }
                
                it("isEnabled 상태 값이 true가 된다") {
                    expect(sut.currentState.isEnabled) == true
                }
            }
            
            context("다음 버튼을 누르면") {
                beforeEach {
                    sut.action.onNext(.nextDidTap)
                }
                
                it("기억을 저장한다") {
                    let memory = try unwrap(useCase.createMemoryMemoryMemory)
                    expect(useCase.createMemoryMemoryCallCount) == 1
                    expect(memory.images) == images
                }
                
                it("memoryRecordCompleteIsRequired 라우팅이 호출된다") {
                    let step = try unwrap(stepBinder.steps.first as? AppStep)
                    expect {
                        guard case .memoryRecordCompleteIsRequired = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return .succeeded
                    }.to(succeed())
                }
            }
        }
    }
    
}
