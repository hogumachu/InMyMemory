//
//  EmotionDetailReactorTests.swift
//  
//
//  Created by 홍성준 on 3/13/24.
//

@testable import EmotionDetailPresentation
import PresentationTestSupport
import EmotionDetailTestSupport
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

final class EmotionDetailReactorTests: QuickSpec {
    
    override class func spec() {
        var sut: EmotionDetailReactor!
        var useCase: EmotionDetailUseCaseMock!
        var stepBinder: StepBinder!
        var disposeBag: DisposeBag!
        var emotionID: UUID!
        var emotion: Emotion!
        
        describe("EmotionDetailReactor 테스트") {
            beforeEach {
                emotionID = .init()
                emotion = .init(
                    id: emotionID,
                    note: "Test Note",
                    emotionType: .good,
                    date: .init()
                )
                useCase = .init()
                useCase.emotionIDEmotion = emotion
                stepBinder = .init()
                disposeBag = .init()
                sut = .init(emotionID: emotionID, useCase: useCase)
                sut.steps
                    .bind(to: stepBinder.step)
                    .disposed(by: disposeBag)
            }
            
            context("새로고침이 호출되면") {
                beforeEach {
                    sut.action.onNext(.refresh)
                }
                
                it("EmotionID를 통해 Emotion 정보를 불러온다") {
                    expect(sut.currentState.emotion?.id) == useCase.emotionIDEmotion?.id
                    expect(useCase.emotionIDCallCount) == 1
                }
                
                it("ViewModel이 생성된다") {
                    expect(sut.currentState.viewModel?.note) == useCase.emotionIDEmotion?.note
                    expect(sut.currentState.viewModel?.emotionType) == useCase.emotionIDEmotion?.emotionType
                }
            }
            
            context("제거 버튼을 누르면") {
                beforeEach {
                    sut.action.onNext(.removeDidTap)
                }
                
                it("제거된다") {
                    expect(useCase.removeEmotionIDCallCount) == 1
                }
                
                it("emotionDetailIsComplete로 라우팅 된다") {
                    let step = try unwrap(stepBinder.steps.last as? AppStep)
                    expect {
                        guard case .emotionDetailIsComplete = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return .succeeded
                    }.to(succeed())
                }
            }
            
            context("Emotion이 없는 상태에서 편집 버튼을 누르면") {
                beforeEach {
                    sut.isStubEnabled = true
                    sut.stub.state.value = .init(emotion: nil)
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
