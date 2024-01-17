//
//  EmotionRecordNotePresentationTests.swift
//  
//
//  Created by 홍성준 on 1/18/24.
//

@testable import EmotionRecordPresentation
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

final class EmotionRecordNotePresentationTests: QuickSpec {
    
    override class func spec() {
        var sut: EmotionRecordNoteReactor!
        var useCase: EmotionRecordUseCaseMock!
        var disposeBag: DisposeBag!
        var stepBinder: EmotionRecordStepBinder!
        var emotionType: EmotionType!
        
        describe("EmotionRecordNoteReactor 테스트") {
            beforeEach {
                useCase = .init()
                emotionType = .good
                sut = .init(emotionType: emotionType, useCase: useCase)
                disposeBag = .init()
                stepBinder = .init()
                sut.steps
                    .bind(to: stepBinder.step)
                    .disposed(by: disposeBag)
            }
            
            context("빈 문자열이 입력되면") {
                beforeEach {
                    sut.action.onNext(.textDidUpdated(""))
                }
                
                it("isEnabled 상태 값이 false가 된다") {
                    expect { sut.currentState.isEnabled } == false
                }
            }
            
            context("비어있지 않은 문자열이 입력되면") {
                beforeEach {
                    sut.action.onNext(.textDidUpdated("Test123"))
                }
                
                it("isEnabled 상태 값이 true가 된다") {
                    expect { sut.currentState.isEnabled } == true
                }
            }
            
            context("다음 버튼이 탭되면") {
                beforeEach {
                    sut.action.onNext(.nextDidTap)
                }
                
                it("감정 기록을 작성한다") {
                    expect { useCase.createEmotionEmotionCallCount } == 1
                    expect { useCase.createEmotionEmotionEmotion?.emotionType } == emotionType
                }
                
                it("완료 화면으로 라우팅한다") {
                    let step = try unwrap(stepBinder.steps.first as? AppStep)
                    expect {
                        guard case .emotionRecordCompleteIsRequired = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return .succeeded
                    }.to(succeed())
                }
            }
        }
    }
    
}
