//
//  Emotion.swift
//
//
//  Created by 홍성준 on 12/31/23.
//

import Foundation

public struct Emotion {
    
    public let id: UUID
    public let note: String
    public let emotionType: EmotionType
    public let date: Date
    
    public init(
        id: UUID = UUID(),
        note: String,
        emotionType: EmotionType,
        date: Date
    ) {
        self.id = id
        self.note = note
        self.emotionType = emotionType
        self.date = date
    }
    
}
