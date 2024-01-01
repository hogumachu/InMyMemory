//
//  MemoryModel.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import Foundation
import SwiftData
import Entities

@Model
public final class MemoryModel {
    
    @Attribute(.unique) public let id: UUID
    public let images: [Data]
    public let note: String
    public let date: Date
    public let updatedAt: Date
    
    public init(
        id: UUID,
        images: [Data],
        note: String,
        date: Date,
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.images = images
        self.note = note
        self.date = date
        self.updatedAt = updatedAt
    }
    
    public convenience init(memory: Memory) {
        self.init(
            id: memory.id,
            images: memory.images,
            note: memory.note,
            date: memory.date
        )
    }
    
}

public extension MemoryModel {
    
    func toEntity() -> Memory {
        return .init(
            id: id,
            images: images,
            note: note,
            date: date
        )
    }
    
}
