//
//  EmotionModel.swift
//
//
//  Created by 홍성준 on 12/31/23.
//

import Foundation
import SwiftData
import Entities

@Model
public final class EmotionModel {
    
    @Attribute(.unique) public let id: UUID
    public let note: String
    public let emotionType: EmotionType
    public let date: Date
    public let updatedAt: Date
    
    public init(
        id: UUID,
        note: String,
        emotionType: EmotionType,
        date: Date,
        updatedAt: Date = Date()
    ) {
        self.note = note
        self.emotionType = emotionType
        self.date = date
        self.updatedAt = updatedAt
    }
    
    public convenience init(emotion: Emotion) {
        self.init(
            id: emotion.id,
            note: emotion.note,
            emotionType: emotion.emotionType,
            date: emotion.date
        )
    }
    
}

public extension EmotionModel {
    
    func toEntity() -> Emotion {
        return .init(
            id: id,
            note: note,
            emotionType: emotionType,
            date: date
        )
    }
    
}
