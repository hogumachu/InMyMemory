//
//  Memory.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import Foundation

public struct Memory {
    
    public let id: UUID
    public let images: [Data]
    public let note: String
    public let date: Date
    
    public init(
        id: UUID = UUID(),
        images: [Data],
        note: String,
        date: Date
    ) {
        self.id = id
        self.images = images
        self.note = note
        self.date = date
    }
    
}
