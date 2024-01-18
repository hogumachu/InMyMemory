//
//  MemoryRecordReactorTests.swift
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

final class MemoryRecordReactorTests: QuickSpec {
    
    override class func spec() {
        var sut: MemoryRecordReactor!
        var stepBinder: StepBinder!
        var disposeBag: DisposeBag!
        
        describe("MemoryRecordReactor 테스트") {
            beforeEach {
                sut = .init()
                stepBinder = .init()
                disposeBag = .init()
                sut.steps
                    .bind(to: stepBinder.step)
                    .disposed(by: disposeBag)
            }
            
            context("이미지 추가 버튼이 선택되면") {
                beforeEach {
                    sut.action.onNext(.addDidTap)
                }
                
                it("memoryRecordPhotoIsRequired 라우팅이 호출된다") {
                    let step = try unwrap(stepBinder.steps.first as? AppStep)
                    expect {
                        guard case .memoryRecordPhotoIsRequired = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return .succeeded
                    }.to(succeed())
                }
            }
            
            context("이미지가 추가되면") {
                let imageData = Data()
                beforeEach {
                    sut.action.onNext(.imageDidTap(imageData))
                }
                
                it("상태 값에 이미지가 추가된다") {
                    expect(sut.currentState.images).to(contain(imageData))
                }
                
                it("memoryRecordPhotoIsComplete 라우팅이 호출된다") {
                    let step = try unwrap(stepBinder.steps.last as? AppStep)
                    expect {
                        guard case .memoryRecordPhotoIsComplete = step else {
                            return .failed(reason: "올바르지 않은 라우팅")
                        }
                        return .succeeded
                    }.to(succeed())
                }
                
                context("다음 버튼이 탭되면") {
                    beforeEach {
                        sut.action.onNext(.nextDidTap)
                    }
                    
                    it("이미지를 가지고 memoryRecordNoteIsRequired로 라우팅한다") {
                        let step = try unwrap(stepBinder.steps.last as? AppStep)
                        expect {
                            guard case .memoryRecordNoteIsRequired(let images) = step else {
                                return .failed(reason: "올바르지 않은 라우팅")
                            }
                            return images == [imageData] ? .succeeded : .failed(reason: "올바르지 않은 이미지")
                        }.to(succeed())
                    }
                }
            }
        }
        
    }
    
}
