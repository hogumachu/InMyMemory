//
//  EmotionRecordUseCaseTests.swift
//
//
//  Created by 홍성준 on 1/19/24.
//

@testable import UseCases
import Entities
import XCTest
import Quick
import Nimble

final class EmotionRecordUseCaseTests: QuickSpec {
    
    override class func spec() {
        var sut: EmotionRecordUseCase!
        var repository: EmotionRepositoryMock!
        
        describe("") {
            beforeEach {
                repository = .init()
                sut = .init(emotionRepository: repository)
            }
            
            context("createEmotion이 호출되면") {
                let emotion: Emotion = .init(id: .init(), note: "", emotionType: .good, date: .init())
                beforeEach {
                    _ = sut.createEmotion(emotion)
                }
                
                it("EmotionRepository의 create(emotion: Emotion)이 호출된다") {
                    expect { repository.createEmotionEmotion?.id } == emotion.id
                    expect { repository.createEmotionCallCount } == 1
                }
            }
        }
    }
    
}
