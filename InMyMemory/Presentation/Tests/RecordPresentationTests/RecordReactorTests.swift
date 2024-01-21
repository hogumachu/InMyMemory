//
//  RecordReactorTests.swift
//
//
//  Created by 홍성준 on 1/21/24.
//

@testable import RecordPresentation
import PresentationTestSupport
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

final class RecordReactorTests: QuickSpec {
    
    override class func spec() {
        var sut: RecordReactor!
        var stepBinder: StepBinder!
        var date: Date!
        var disposeBag: DisposeBag!
        
        describe("RecordReactor 테스트") {
            beforeEach {
                date = .init()
                stepBinder = .init()
                disposeBag = .init()
                sut = .init(date: date)
                sut.steps
                    .bind(to: stepBinder.step)
                    .disposed(by: disposeBag)
            }
            
            context("Close 버튼이 탭되면") {
                beforeEach {
                    sut.action.onNext(.closeDidTap)
                }
                
                it("recordIsComplete 라우팅이 호출된다") {
                    let step = try unwrap(stepBinder.steps.first as? AppStep)
                    expect {
                        guard case .recordIsComplete = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return .succeeded
                    }.to(succeed())
                }
            }
            
            context("감정 기록 버튼이 탭되면") {
                beforeEach {
                    sut.action.onNext(.emotionRecordDidTap)
                }
                
                it("emotionRecordIsRequired 라우팅이 호출된다") {
                    let step = try unwrap(stepBinder.steps.first as? AppStep)
                    expect {
                        guard case .emotionRecordIsRequired(let routingDate) = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return date == routingDate ? .succeeded : .failed(reason: "올바르지 않은 Date")
                    }.to(succeed())
                }
            }
            
            context("기억 기록 버튼이 탭되면") {
                beforeEach {
                    sut.action.onNext(.memoryRecordDidTap)
                }
                
                it("memoryRecordIsRequired 라우팅이 호출된다") {
                    let step = try unwrap(stepBinder.steps.first as? AppStep)
                    expect {
                        guard case .memoryRecordIsRequired(let routingDate) = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return date == routingDate ? .succeeded : .failed(reason: "올바르지 않은 Date")
                    }.to(succeed())
                }
            }
            
            context("할일 기록 버튼이 탭되면") {
                beforeEach {
                    sut.action.onNext(.todoRecordDidTap)
                }
                
                it("todoRecordIsRequired 라우팅이 호출된다") {
                    let step = try unwrap(stepBinder.steps.first as? AppStep)
                    expect {
                        guard case .todoRecordIsRequired(let routingDate) = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return date == routingDate ? .succeeded : .failed(reason: "올바르지 않은 Date")
                    }.to(succeed())
                }
            }
        }
    }
    
}
