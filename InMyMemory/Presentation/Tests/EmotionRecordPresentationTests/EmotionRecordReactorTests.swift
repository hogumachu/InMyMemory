//
//  EmotionRecordReactorTests.swift
//
//
//  Created by 홍성준 on 1/17/24.
//

@testable import EmotionRecordPresentation
import PresentationTestSupport
import EmotionRecordTestSupport
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

final class EmotionRecordReactorTests: QuickSpec {
    
    override class func spec() {
        var sut: EmotionRecordReactor!
        var useCase: EmotionRecordUseCaseMock!
        var disposeBag: DisposeBag!
        var stepBinder: StepBinder!
        
        describe("EmotionRecordReactor 테스트") {
            beforeEach {
                useCase = .init()
                sut = .init(useCase: useCase)
                disposeBag = .init()
                stepBinder = .init()
                sut.steps
                    .bind(to: stepBinder.step)
                    .disposed(by: disposeBag)
            }
            
            context("감정이 선택되면") {
                let emotionType: EmotionType = .good
                
                beforeEach {
                    sut.action.onNext(.buttonDidTap(emotionType))
                }
                
                it("해당 감정을 가지고 라우팅 한다.") {
                    let step = try unwrap(stepBinder.steps.first as? AppStep)
                    expect {
                        guard case .emotionRecordNoteIsRequired(let type) = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return type == emotionType ? .succeeded : .failed(reason: "올바르지 않은 감정 타입")
                    }.to(succeed())
                }
            }
        }
    }
    
}

