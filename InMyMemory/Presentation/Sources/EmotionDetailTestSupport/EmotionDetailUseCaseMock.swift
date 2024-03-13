//
//  EmotionDetailUseCaseMock.swift
//
//
//  Created by 홍성준 on 3/13/24.
//

import Foundation
import Interfaces
import Entities
import RxSwift

public final class EmotionDetailUseCaseMock: EmotionDetailUseCaseInterface {
    
    public init() {}
    
    
    public var emotionIDCallCount = 0
    public var emotionIDID: UUID?
    public func emotion(id: UUID) -> Single<Emotion?> {
        emotionIDCallCount += 1
        emotionIDID = id
        return .just(nil)
    }
    
    public var removeEmotionIDCallCount = 0
    public var removeEmotionIDEmotionID: UUID?
    public func remove(emotionID: UUID) -> Single<Void> {
        removeEmotionIDCallCount += 1
        removeEmotionIDEmotionID = emotionID
        return .just(())
    }
    
}
