//
//  EmotionRecordUseCaseMock.swift
//
//
//  Created by 홍성준 on 1/17/24.
//

import Interfaces
import Entities
import RxSwift

public final class EmotionRecordUseCaseMock: EmotionRecordUseCaseInterface {
    
    public init() {}
    
    
    public var createEmotionEmotionCallCount = 0
    public var createEmotionEmotionEmotion: Emotion?
    public func createEmotion(_ emotion: Emotion) -> Single<Void> {
        createEmotionEmotionCallCount += 1
        createEmotionEmotionEmotion = emotion
        return .just(())
    }
    
}
