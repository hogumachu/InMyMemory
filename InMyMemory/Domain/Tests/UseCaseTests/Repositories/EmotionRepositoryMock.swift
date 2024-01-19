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

final class EmotionRepositoryMock: EmotionRepositoryInterface {
    
    init() {}
    
    var createEmotionCallCount = 0
    var createEmotionEmotion: Emotion?
    func create(emotion: Emotion) -> Single<Void> {
        createEmotionCallCount += 1
        createEmotionEmotion = emotion
        return .just(())
    }
    
    var readEmotionIDCallCount = 0
    var readEmotionIDEmotionID: UUID?
    var readEmotionIDEmotion: Emotion?
    func read(emotionID: UUID) -> Single<Emotion?> {
        readEmotionIDCallCount += 1
        readEmotionIDEmotionID = emotionID
        return .just(readEmotionIDEmotion)
    }
    
    var readGreaterThanCallCount = 0
    var readGreaterThanDate: Date?
    var readGreaterThanEmotions: [Emotion] = []
    func read(greaterThan date: Date) -> Single<[Emotion]> {
        readGreaterThanCallCount += 1
        readGreaterThanDate = date
        return .just(readGreaterThanEmotions)
    }
    
    var readGreaterOrEqualThanLessThanCallCount = 0
    var readGreaterOrEqualThanLessThanGreaterOrEqualDate: Date?
    var readGreaterOrEqualThanLessThanLessDate: Date?
    var readGreaterOrEqualThanLessThanEmotions: [Emotion] = []
    func read(greaterOrEqualThan greaterOrEqualDate: Date, lessThan lessDate: Date) -> Single<[Emotion]> {
        readGreaterOrEqualThanLessThanCallCount += 1
        readGreaterOrEqualThanLessThanGreaterOrEqualDate = greaterOrEqualDate
        readGreaterOrEqualThanLessThanLessDate = lessDate
        return .just(readGreaterOrEqualThanLessThanEmotions)
    }
    
    var readKeywordCallCount = 0
    var readKeywordKeyword: String?
    var readKeywordEmotions: [Emotion] = []
    func read(keyword: String) -> Single<[Emotion]> {
        readKeywordCallCount += 1
        readKeywordKeyword = keyword
        return .just(readKeywordEmotions)
    }
    
    var updateEmotionCallCount = 0
    var updateEmotionEmotion: Emotion?
    func update(emotion: Emotion) -> Single<Void> {
        updateEmotionCallCount += 1
        updateEmotionEmotion = emotion
        return .just(())
    }
    
    var deleteEmotionCallCount = 0
    var deleteEmotionEmotion: Emotion?
    func delete(emotion: Emotion) -> Single<Void> {
        deleteEmotionCallCount += 1
        deleteEmotionEmotion = emotion
        return .just(())
    }
    
}
