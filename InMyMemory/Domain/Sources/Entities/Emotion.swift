//
//  Emotion.swift
//
//
//  Created by 홍성준 on 12/31/23.
//

import Foundation

public struct Emotion {
    
    public let note: String
    public let emotionType: EmotionType
    public let date: Date
    public let updatedAt: Date
    
    public init(
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
    
}
