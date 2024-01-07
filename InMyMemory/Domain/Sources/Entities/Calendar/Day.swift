//
//  Day.swift
//
//
//  Created by 홍성준 on 1/7/24.
//

import Foundation

public struct Day {
    public let metadata: DayMetaData
    public let items: [DayItem]
    
    public init(metadata: DayMetaData, items: [DayItem]) {
        self.metadata = metadata
        self.items = items
    }
}

public enum DayItem {
    case emotion(Emotion)
    case memory(Memory)
    case todo(Todo)
}
