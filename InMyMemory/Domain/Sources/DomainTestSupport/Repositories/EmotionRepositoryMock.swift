//
//  EmotionRepositoryMock.swift
//
//
//  Created by 홍성준 on 1/19/24.
//

import Foundation
import Interfaces
import Entities
import RxSwift

public final class EmotionRepositoryMock: EmotionRepositoryInterface {
    
    public init() {}
    
    public var createEmotionCallCount = 0
    public var createEmotionEmotion: Emotion?
    public func create(emotion: Emotion) -> Single<Void> {
        createEmotionCallCount += 1
        createEmotionEmotion = emotion
        return .just(())
    }
    
    public var readEmotionIDCallCount = 0
    public var readEmotionIDEmotionID: UUID?
    public var readEmotionIDEmotion: Emotion?
    public func read(emotionID: UUID) -> Single<Emotion?> {
        readEmotionIDCallCount += 1
        readEmotionIDEmotionID = emotionID
        return .just(readEmotionIDEmotion)
    }
    
    public var readGreaterThanCallCount = 0
    public var readGreaterThanDate: Date?
    public var readGreaterThanEmotions: [Emotion] = []
    public func read(greaterThan date: Date) -> Single<[Emotion]> {
        readGreaterThanCallCount += 1
        readGreaterThanDate = date
        return .just(readGreaterThanEmotions)
    }
    
    public var readGreaterOrEqualThanLessThanCallCount = 0
    public var readGreaterOrEqualThanLessThanGreaterOrEqualDate: Date?
    public var readGreaterOrEqualThanLessThanLessDate: Date?
    public var readGreaterOrEqualThanLessThanEmotions: [Emotion] = []
    public func read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date) -> Single<[Emotion]> {
        readGreaterOrEqualThanLessThanCallCount += 1
        readGreaterOrEqualThanLessThanGreaterOrEqualDate = greaterOrEqualDate
        readGreaterOrEqualThanLessThanLessDate = lessDate
        return .just(readGreaterOrEqualThanLessThanEmotions)
    }
    
    public var readKeywordCallCount = 0
    public var readKeywordKeyword: String?
    public var readKeywordEmotions: [Emotion] = []
    public func read(keyword: String) -> Single<[Emotion]> {
        readKeywordCallCount += 1
        readKeywordKeyword = keyword
        return .just(readKeywordEmotions)
    }
    
    public var updateEmotionCallCount = 0
    public var updateEmotionEmotion: Emotion?
    public func update(emotion: Emotion) -> Single<Void> {
        updateEmotionCallCount += 1
        updateEmotionEmotion = emotion
        return .just(())
    }
    
    public var deleteEmotionCallCount = 0
    public var deleteEmotionEmotion: Emotion?
    public func delete(emotion: Emotion) -> Single<Void> {
        deleteEmotionCallCount += 1
        deleteEmotionEmotion = emotion
        return .just(())
    }
    
}
